//
//  InitialViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let username = UserInfoManager.getUsername()
        
        if username == nil {
            self.performSegueWithIdentifier("setupUser", sender: self)
        } else {
            self.performSegueWithIdentifier("userExists", sender: self)
        }
    }
}
