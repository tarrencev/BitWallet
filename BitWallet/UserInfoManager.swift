//
//  UserInfoManager.swift
//  Prox
//
//  Created by Tarrence van As on 7/20/14.
//  Copyright (c) 2014 Prox. All rights reserved.
//

import UIKit
import Security

let KEYCHAIN_SERVICE: String =  "BitWallet"

class UserInfoManager: NSObject {
    class func createUserAccount(username: String) {
        let beaconUUID = NSUUID.UUID().UUIDString
//        let keyChainItem = CTKeychainItem(service: KEYCHAIN_SERVICE, account: username)
        let privateKey = generatePrivateKey()
        
        NSUserDefaults.standardUserDefaults().setObject(username, forKey:"Username")
        NSUserDefaults.standardUserDefaults().setObject(beaconUUID, forKey:"BeaconUUID")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    class func generatePrivateKey() -> String {
        return "12312312413"
    }
    
    class func getUsername() -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let username: AnyObject = userDefaults.objectForKey("Username") {
            return String(username as NSString)
        }
        
        return nil;
    }
    
    class func getBeaconUUID() -> String? {
        let beaconUUIDString = NSUserDefaults.standardUserDefaults().objectForKey("BeaconUUID") as NSString
        if beaconUUIDString.length > 0 {
            return String(beaconUUIDString)
        }
        
        return nil;
    }
    
    class func resetKeyManager() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("Username")
    }
}
