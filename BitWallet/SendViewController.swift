//
//  TransactionsViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = ["We", "Heart", "Swift"],
    colors = [0x16A085, 0x3498DB, 0x8E44AD, 0x2C3E50, 0xF1C40F, 0xF39C12, 0xC0392B, 0x7F8C8D]
    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "SendTableViewCell", bundle: nil)
        
        tableView!.registerNib(nib, forCellReuseIdentifier: "userCell")
        tableView!.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        tableView!.separatorColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:SendTableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("userCell") as SendTableViewCell
        
        cell.setUsername(items[indexPath.row], color: colors[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
