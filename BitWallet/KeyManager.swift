//
//  KeyManager.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/24/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import Foundation

class KeyManager {
    
    class func generateBitcoinKey() -> BTCKey {
        
        let length: UInt = 32,
            secret = NSMutableData(length: Int(length))
        var sanityCheck = noErr
        
        sanityCheck = SecRandomCopyBytes(kSecRandomDefault, length, UnsafeMutablePointer<UInt8>(secret!.mutableBytes))
        
        if sanityCheck != noErr {
            println("Issue generating private key")
        }
        
        assert(secret!.length == 32, "Secret must be 32 bytes long")
        return BTCKey(privateKey: secret)
    }
    
    class func getPrivateKey(name: String) -> String {
        
        var key: BTCKey?
        
        if !addressesDBExists() {
            createAddressesDB()
            key = createKey(name)
        } else {
            key = readKeyFromDB(name)
            if key == nil {
                key = createKey(name)
            }
        }
            
        let privateKeyAddress = BTCPrivateKeyAddress(data: key?.privateKey)
        
        return privateKeyAddress.base58String()
    }
    
    
    class func getKey(name: String) -> BTCKey {
        
        var key: BTCKey?
        
        if !addressesDBExists() {
            createAddressesDB()
            key = createKey(name)
        } else {
            key = readKeyFromDB(name)
        }
        
        return key!
    }
    
    class func generateMultiSigScript(name: String, pubKeys: NSArray) {
        let script = BTCScript(publicKeys: pubKeys, signaturesRequired: 2)
        println(script.scriptHashAddress())
    }
    
    class func getPublicKey(name: String) -> String {
        
        var key: BTCKey?
        
        if !addressesDBExists() {
            createAddressesDB()
            key = createKey(name)
        } else {
            key = readKeyFromDB(name)
        }

        let publicKeyAddress = BTCPublicKeyAddress(data: BTCHash160(key?.publicKey))
        
        return publicKeyAddress.base58String()
    }
    
    private class func createKey(name: String) -> BTCKey {
        println("create key")
        let key = generateBitcoinKey()
        writeKeyToDB(name, key: key)
        return key
    }
    
    private class func addressesDBExists() -> Bool {
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Addresses")
        if err != nil {
            
            // Table doesn't exist
            if err == 1 {
                return false
            }
            
        } else {
            return true
        }
        
        return false
    }
    
    private class func createAddressesDB() {
        if let err = SD.createTable("Addresses", withColumnNamesAndTypes: ["Name": .StringVal, "PrivateKey": .StringVal, "PublicKey": .StringVal]) {
            println("create error")
        } else {
            println("create success")
        }
    }
    
    class func writeKeyToDB(name: String, key: BTCKey) {
        
        if !addressesDBExists() {
            createAddressesDB()
        }
        
        let privateKeyHex = key.privateKey.toHexString()

        if let err = SD.executeChange("INSERT INTO Addresses (Name, PrivateKey) VALUES (?, ?)", withArgs: [name, privateKeyHex]) {
            //there was an error during the insert, handle it here
        } else {
            //no error, the row was inserted successfully
        }

    }
    
    class func readKeyFromDB(name: String) -> BTCKey? {
        
        if !addressesDBExists() {
            return nil
        }
        
        println("read key")
        
        let (resultSet, err) = SD.executeQuery("SELECT PrivateKey FROM Addresses WHERE Name = ?", withArgs: [name])
        if err != nil {
            return nil
        } else {
            if resultSet.count > 0 {
                let row = resultSet[0],
                    privateKeyHex = row["PrivateKey"]?.asString(),
                    key = BTCKey(privateKey: BTCDataWithHexString(privateKeyHex))
                return key
            } else {
                return nil
            }
        }
    }
    
    class func flushDB() {
//        SD.executeQuery("DELETE FROM Addresses")
        
        if (addressesDBExists()) {
            SD.deleteTable("Addresses")
        }
    }
}