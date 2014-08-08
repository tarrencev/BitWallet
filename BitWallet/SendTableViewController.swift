//
//  SendTableViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/6/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendTableViewController: UITableViewController, SendInitiatorCellDelegate {
    
    let sections = ["Nearby", "Recent", "Favorites"],
    sendItems = ["Search", "Wesley V", "John S", "Jordan K",
        "Andrew D", "Jessica L", "Mom", "Jake O", "Jeff B", "Zach W",
        "Peter P"]
    
    
    var selectedIndex: NSIndexPath?
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex != nil && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> Int {
        return 65 * indexPath.row;
    }
    
    func closeCell(cell: SendInitiatorTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell as UITableViewCell)
        closeInitiatorCell(cell, indexPath: indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendInitiatorCellNib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil),
            searchCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.registerNib(sendInitiatorCellNib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView.registerNib(searchCellNib, forCellReuseIdentifier: "searchCell")
        tableView.backgroundColor = Utilities.baseColor()
        tableView.separatorColor = UIColor.clearColor()
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
            
            cell.setUsername(sendItems[indexPath.row])
            cell.setColor(Utilities.getColorForRow(indexPath.row))
            cell.delegate = self
            
            return cell
        }
    }
    
    func closeInitiatorCell(cell: SendInitiatorTableViewCell, indexPath: NSIndexPath) {
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, 0, self.tableView.frame.width, UIScreen.mainScreen().bounds.size.height - 20)
        })
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedIndex = nil
        cell.close()

        tableView.scrollEnabled = true
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func openInitiatorCell(cell: SendInitiatorTableViewCell, indexPath: NSIndexPath) {
        tableView.scrollEnabled = false
        
        // Select keyboard
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, 0 - CGFloat(self.calcTopOffsetToCell(indexPath) - 20), self.tableView.frame.size.width, self.tableView.frame.size.height + 190)
        })
        
        selectedIndex = indexPath
        cell.open()

        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as SendInitiatorTableViewCell,
            notificationCenter = NSNotificationCenter.defaultCenter()
        
        // Selected the same cell again so collapse it
        if selectedIndex == indexPath {
            closeInitiatorCell(cell, indexPath: indexPath)
        } else {
            openInitiatorCell(cell, indexPath: indexPath)
        }
        
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
