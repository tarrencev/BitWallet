//
//  ReceiveViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class ReceiveViewController: UIViewController {
    
    let address1 = UILabel(frame: CGRectMake(0, 50, 320, 50)),
        address2 = UILabel(frame: CGRectMake(0, 100, 320, 50)),
        address3 = UILabel(frame: CGRectMake(0, 150, 320, 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        address1.text = KeyManager.getPrivateKey("key1")
        address2.text = KeyManager.getPrivateKey("key2")
        address3.text = KeyManager.getPrivateKey("key3")
        
        self.view.addSubview(address1)
        self.view.addSubview(address2)
        self.view.addSubview(address3)
        
        let pubKeys: NSArray = NSArray(objects: KeyManager.getKey("key1").valueForKey("compressedPublicKey")!, KeyManager.getKey("key2").valueForKey("compressedPublicKey")!, KeyManager.getKey("key3").valueForKey("compressedPublicKey")!)
        KeyManager.generateMultiSigScript("test", pubKeys: pubKeys)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
