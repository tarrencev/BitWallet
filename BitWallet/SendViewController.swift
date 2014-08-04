//
//  TransactionsViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sections = ["Nearby", "Recent", "Favorites"],
        sendItems = [["Peets Coffee"],
                    ["Wesley V", "John S", "Jordan K"],
                    ["Andrew D", "Jessica L", "Mom"]],
        colors = [[0x16A085], [0x3498DB, 0x8E44AD, 0x2C3E50], [0xF1C40F, 0xF39C12, 0xC0392B, 0x7F8C8D]]
    
    var selectedIndex: NSIndexPath?
    
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
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> Int {
        var offset = indexPath.section * 20
        for index in 0..<indexPath.section {
            offset += 65 * sendItems[index].count
        }
        
        offset += 65 * indexPath.row
        
        return offset
    }
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        var sectionHeaderViewController = SectionHeaderViewController()
        
//        sectionHeaderViewController.sectionNameLabel!.text = sections[section]
        
        return sectionHeaderViewController.view
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.sendItems[section].count
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return sections[section]
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
        
        cell.setUsername(sendItems[indexPath.section][indexPath.row], color: colors[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if selectedIndex == indexPath {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            selectedIndex = nil
        } else {
            println("section " + String(indexPath.section))
            println("row" + String(indexPath.row))
            tableView.setContentOffset(CGPoint(x: 0, y: calcTopOffsetToCell(indexPath)), animated: true)
            selectedIndex = indexPath
        }

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
