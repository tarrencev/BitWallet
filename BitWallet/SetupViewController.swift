//
//  SetupViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func doneButton(sender: AnyObject) {
        // Generate wallet
        UserInfoManager.createUserAccount(usernameTextField.text)
        self.performSegueWithIdentifier("setupComplete", sender: self.navigationController)
    }
    
    @IBAction func keyBtnPress(sender: AnyObject) {
        let button = sender as UIButton
        
        switch (button.tag) {
            case 201:
                let keyName = "key1",
                privateKey = KeyManager.getPrivateKey(keyName),
                publicKey = KeyManager.getPublicKey(keyName)
                println(privateKey)
                println(publicKey)
            
            case 202:
                let keyName = "key2",
                privateKey = KeyManager.getPrivateKey(keyName),
                publicKey = KeyManager.getPublicKey(keyName)
                println(privateKey)
                println(publicKey)
            
            case 203:
                let keyName = "key3",
                privateKey = KeyManager.getPrivateKey(keyName),
                publicKey = KeyManager.getPublicKey(keyName)
                println(privateKey)
                println(publicKey)
            
            default:
                println("ISSUE")
                break;
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        
    }

}
