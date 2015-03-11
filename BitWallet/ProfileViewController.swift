//
//  ProfileViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var transactionsTableViewController = TransactionsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(transactionsTableViewController)
        self.view.addSubview(transactionsTableViewController.view)
        transactionsTableViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIsScrollingOnScreen() {
        println("scrolling on screen")
        transactionsTableViewController.viewIsScrollingOnScreen()
    }

}
