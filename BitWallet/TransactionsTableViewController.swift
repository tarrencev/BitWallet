//
//  TransactionsTableViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/15/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Chain.getAddress(UserInfoManager.getPublicAddress(), )
        

        Chain.sharedInstance().getAddressTransactions(UserInfoManager.getPublicAddress(), completionHandler: { (response, error) -> Void in
            println(response)
            println(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionsCell", forIndexPath: indexPath) as TransactionsTableViewCell

        // Configure the cell...

        return cell
    }
}
