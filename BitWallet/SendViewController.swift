//
//  SendViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/11/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
    
    var sendTableViewController = SendTableViewController(),
        sendNavViewController = SendNavViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navbar
        self.addChildViewController(sendNavViewController)
        self.view.addSubview(sendNavViewController.view)
        sendNavViewController.didMoveToParentViewController(self)
        
        // Setup tableview
        self.addChildViewController(sendTableViewController)
        self.view.addSubview(sendTableViewController.view)
        sendTableViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
