//
//  TransactionsTableViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/15/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    var transactions: Array<Transaction> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendInitiatorCellNib = UINib(nibName: "TransactionsTableViewCell", bundle: nil)
        tableView.registerNib(sendInitiatorCellNib, forCellReuseIdentifier: "transactionsCell")

        Chain.sharedInstance().getAddressTransactions(UserInfoManager.getPublicAddress(), limit: 2, completionHandler: { (response, error) -> Void in
            
            if response != nil {
                let responseDictionary = response as NSDictionary,
                    resultsArray = responseDictionary["results"] as Array<NSDictionary>
                
                for transactionData in resultsArray {
                    let transaction = Transaction(rawData: transactionData)
                    self.transactions.append(transaction)
                }
                
                self.tableView.reloadData()
            } else {
                println(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("transactionsCell", forIndexPath: indexPath) as TransactionsTableViewCell

        let transaction = transactions[indexPath.row],
            addresses = transaction.amount
        
            cell.setUser(transaction.outputs[0].addresses[0])
            cell.setAmount(String(transaction.amount))

        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 65
    }
}
