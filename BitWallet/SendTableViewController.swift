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
    sendItems = ["Search", "Wesley V", "John S", "Jordan K",
        "Andrew D", "Jessica L", "Mom"],
    colors = [0x3498DB, 0x8E44AD, 0xF1C40F, 0xF39C12, 0xC0392B, 0x3498DB, 0x16A085]
    
    var selectedIndex: NSIndexPath?
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex != nil && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> Int {
        return 65 * indexPath.row;
    }
    
    func refresh() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendInitiatorCellNib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil),
            searchCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.registerNib(sendInitiatorCellNib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView.registerNib(searchCellNib, forCellReuseIdentifier: "searchCell")
        tableView.backgroundColor = Utilities.baseColor()
        tableView.separatorColor = UIColor.clearColor()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.sendItems.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        if (indexPath.row == 0) {
            var cell = self.tableView!.dequeueReusableCellWithIdentifier("searchCell") as SearchTableViewCell
            
            return cell
        } else {
            var cell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
            
            cell.setUsername(sendItems[indexPath.row], color: colors[indexPath.row])
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as SendInitiatorTableViewCell,
            notificationCenter = NSNotificationCenter.defaultCenter()
        
        // Selected the same cell again so collapse it
        if selectedIndex == indexPath {
            notificationCenter.postNotification("sendCellSelected")
            
            UIView.animateWithDuration(0.5, animations: {
                tableView.frame = CGRectMake(tableView.frame.origin.x, 0, tableView.frame.size.width, tableView.frame.size.height + 190)
                })
            
            cell.amountTextfield.resignFirstResponder()
            cell.amountTextfield.text = ""
            cell.noteTextField.resignFirstResponder()
            cell.noteTextField.text = ""
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            selectedIndex = nil
            
            tableView.scrollEnabled = true
        } else {
            
            tableView.scrollEnabled = false
            
            // Select keyboard
            UIView.animateWithDuration(0.5, animations: {
                tableView.frame = CGRectMake(tableView.frame.origin.x, 0 - CGFloat(self.calcTopOffsetToCell(indexPath) - 20), tableView.frame.size.width, tableView.frame.size.height + 190)
            })
            
            cell.amountTextfield.becomeFirstResponder()
            
            selectedIndex = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // Set row height
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if cellIsSelected(indexPath) {
            return 335
        } else if (indexPath.row == 0) {
            return 44
        }
        
        return 65
    }
}
