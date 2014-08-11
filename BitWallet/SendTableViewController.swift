//
//  SendTableViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/6/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendTableViewController: UITableViewController, SendInitiatorCellDelegate {
    
    let NAVBAR_HEIGHT: CGFloat = 44,
        STATUSBAR_HEIGHT: CGFloat = 20
    
    let sections = ["Nearby", "Recent", "Favorites"],
    sendItems = ["Wesley V", "John S", "Jordan K",
        "Andrew D", "Jessica L", "Mom", "Jake O", "Jeff B", "Zach W",
        "Peter P"]
    
    
    var selectedIndex: NSIndexPath?
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex != nil && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(65 * indexPath.row);
    }
    
    func closeCell(cell: SendInitiatorTableViewCell) {
        closeInitiatorCell(cell, indexPath: selectedIndex!)
    }
    
    func closeSelectedCell() {
        if selectedIndex != nil {
            let cell = self.tableView.cellForRowAtIndexPath(selectedIndex) as SendInitiatorTableViewCell
            closeInitiatorCell(cell, indexPath: selectedIndex!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, NAVBAR_HEIGHT, self.view.frame.size.width, UIScreen.mainScreen().bounds.height - NAVBAR_HEIGHT - STATUSBAR_HEIGHT)
        
        let sendInitiatorCellNib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil)
        tableView.registerNib(sendInitiatorCellNib, forCellReuseIdentifier: "sendInitiatorCell")
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
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
        
        cell.setUsername(sendItems[indexPath.row])
        cell.setColor(Utilities.getColorForRow(indexPath.row))
        cell.delegate = self
        
        return cell
    }
    
    func closeInitiatorCell(cell: SendInitiatorTableViewCell, indexPath: NSIndexPath) {
        
        let x = self.tableView.frame.origin.x,
            y: CGFloat = NAVBAR_HEIGHT,
            width = self.tableView.frame.size.width,
            height = tableView.frame.size.height - 400 - NAVBAR_HEIGHT - STATUSBAR_HEIGHT
        
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = CGRectMake(x, y, width, height)
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
        
        let x = self.tableView.frame.origin.x,
            y: CGFloat = 0 - (self.calcTopOffsetToCell(indexPath)),
            width = self.tableView.frame.size.width,
            height = tableView.frame.size.height + 400 + STATUSBAR_HEIGHT + NAVBAR_HEIGHT
        
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = CGRectMake(x, y, width, height)
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
        }
        
        return 65
    }
}
