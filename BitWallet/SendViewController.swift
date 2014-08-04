//
//  TransactionsViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = ["Wesley V", "John S", "Jordan K", "Andrew D", "Jessica L"],
        colors = [0x16A085, 0x3498DB, 0x8E44AD, 0x2C3E50, 0xF1C40F, 0xF39C12, 0xC0392B, 0x7F8C8D],
        selectedIndex: NSIndexPath?
    
    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil)
        
        tableView!.registerNib(nib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView!.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        tableView!.separatorColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex && selectedIndex == cellIndex ? true : false
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:SendInitiatorTableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
        
        cell.setUsername(items[indexPath.row], color: colors[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        selectedIndex = indexPath

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if cellIsSelected(indexPath) {
            return 264
        }
        
        return 65
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
