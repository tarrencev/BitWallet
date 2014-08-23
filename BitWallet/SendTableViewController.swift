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
        STATUSBAR_HEIGHT: CGFloat = 20,
        SECTION_HEADER_HEIGHT: CGFloat = 30,
        ROW_CELL_HEIGHT: CGFloat = 65,
        TABLEVIEW_SCROLL_ANIMATION_DURATION: Double = 0.3
    
    let sections = ["Nearby", "Recent", "Favorites"],
        sectionValues = [["Wesley V", "John S"], ["Jordan Kohl", "Andrew Drozdov", "Jessica Love", "Mom"],   ["Jake Oberon", "Maximus Decimus Meridius", "Russ Darrow",
        "Peter Pan"]]
    
    var selectedIndex: NSIndexPath?,
        closeTableViewRect: CGRect?
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex != nil && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> CGFloat {
        var rowsHeight: CGFloat = ROW_CELL_HEIGHT * CGFloat(indexPath.row) + SECTION_HEADER_HEIGHT * CGFloat(indexPath.section)
        
        for var index = 0; index < indexPath.section; index++ {
            rowsHeight += CGFloat(sectionValues[index].count) * ROW_CELL_HEIGHT
        }
        
        return rowsHeight + SECTION_HEADER_HEIGHT;
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame = CGRectMake(self.view.frame.origin.x, NAVBAR_HEIGHT, self.view.frame.size.width, UIScreen.mainScreen().bounds.height - NAVBAR_HEIGHT - STATUSBAR_HEIGHT)
        
        let sendInitiatorCellNib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil)
        tableView.registerNib(sendInitiatorCellNib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView.backgroundColor = Utilities.baseColor()
//        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.sections.count
    }
    
    override func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return SECTION_HEADER_HEIGHT
    }
    
    override func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        var sendSectionHeaderView = SendSectionHeaderView(frame: CGRectMake(0, 0, tableView.frame.size.width, SECTION_HEADER_HEIGHT))
        
        let sectionName = sections[section]
        sendSectionHeaderView.setSectionTitle(sectionName)
        
        return sendSectionHeaderView as UIView
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        let rowsInSection = sectionValues[section].count
        return rowsInSection
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell,
            username = sectionValues[indexPath.section][indexPath.row]
        
        var cellAbsoluteRowIndex = indexPath.row
        
        for var index = 0; index < indexPath.section; index++ {
            cellAbsoluteRowIndex += sectionValues[index].count
        }
        
        cell.setUsername(username)
        cell.setColor(Utilities.getColorForIndex(cellAbsoluteRowIndex))
        cell.delegate = self
        
        return cell
    }
    
    func closeInitiatorCell(cell: SendInitiatorTableViewCell, indexPath: NSIndexPath) {
        
        UIView.animateWithDuration(TABLEVIEW_SCROLL_ANIMATION_DURATION, animations: {
            self.tableView.frame = self.closeTableViewRect! //CGRectMake(x, y, width, height)
        })
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedIndex = nil
        cell.close()
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollEnabled = true
    }
    
    func openInitiatorCell(cell: SendInitiatorTableViewCell, indexPath: NSIndexPath) {
        closeTableViewRect = tableView.frame
        tableView.scrollEnabled = false
        
        let x = tableView.frame.origin.x,
            y: CGFloat = 0 - calcTopOffsetToCell(indexPath),
            width = tableView.frame.size.width,
            height = tableView.frame.size.height + 335 + 190
        
        UIView.animateWithDuration(TABLEVIEW_SCROLL_ANIMATION_DURATION, animations: {
            self.tableView.frame = CGRectMake(x, y, width, height)
        })

        selectedIndex = indexPath
        cell.open()
        
        tableView.beginUpdates()
        tableView.endUpdates()
        

    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as SendInitiatorTableViewCell
        
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
