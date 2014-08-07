//
//  SendTableViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/6/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendTableViewController: UITableViewController {
    
    let sections = ["Nearby", "Recent", "Favorites"],
    sendItems = ["Wesley V", "John S", "Jordan K",
        "Andrew D", "Jessica L", "Mom"],
    colors = [0x16A085, 0x3498DB, 0x8E44AD, 0x2C3E50, 0xF1C40F, 0xF39C12, 0xC0392B, 0x7F8C8D]
    
    var selectedIndex: NSIndexPath?
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex != nil && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> Int {
        return 65 * indexPath.row;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        tableView.separatorColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.sendItems.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
        
        cell.setUsername(sendItems[indexPath.row], color: colors[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as SendInitiatorTableViewCell
        
        // Selected the same cell again so collapse it
        if selectedIndex == indexPath {
            UIView.animateWithDuration(0.2, animations: {
                tableView.frame = CGRectMake(tableView.frame.origin.x, 0, tableView.frame.size.width, tableView.frame.size.height + 190)
                }, completion: { (finished: Bool) in
                    
            })
            
            cell.amountTextfield.resignFirstResponder()
            
            // Dismiss keyboard
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            selectedIndex = nil
            
            tableView.scrollEnabled = true
        } else {
            
            tableView.scrollEnabled = false
            
            // Select keyboard
            UIView.animateWithDuration(0.1, animations: {
                tableView.frame = CGRectMake(tableView.frame.origin.x, 0 - CGFloat(self.calcTopOffsetToCell(indexPath)), tableView.frame.size.width, tableView.frame.size.height + 190)
                }, completion: { (finished: Bool) in
                    self.selectedIndex = indexPath
                    cell.amountTextfield.becomeFirstResponder()
            })
            
            selectedIndex = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // Set row height
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if cellIsSelected(indexPath) {
            return 335
        }
        
        return 65
    }
}
