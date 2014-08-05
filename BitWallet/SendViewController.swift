//
//  TransactionsViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    let sections = ["Nearby", "Recent", "Favorites"],
        sendItems = ["Wesley V", "John S", "Jordan K",
                    "Andrew D", "Jessica L", "Mom"],
        colors = [0x16A085, 0x3498DB, 0x8E44AD, 0x2C3E50, 0xF1C40F, 0xF39C12, 0xC0392B, 0x7F8C8D]
    
    var selectedIndex: NSIndexPath?
    
    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup send initiator tableview cell
        var nib = UINib(nibName: "SendInitiatorTableViewCell", bundle: nil)
        tableView!.registerNib(nib, forCellReuseIdentifier: "sendInitiatorCell")
        tableView!.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        tableView!.separatorColor = UIColor.clearColor()
        
        // Listen for keyboard show/hide events
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func cellIsSelected(cellIndex: NSIndexPath) -> Bool {
        return selectedIndex && selectedIndex == cellIndex ? true : false
    }
    
    func calcTopOffsetToCell(indexPath: NSIndexPath) -> Int {
        return 65 * indexPath.row;
    }
    
    // MARK: TableView logic
    
//    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
//        var sectionHeaderViewController = SectionHeaderViewController()
//        
////        sectionHeaderViewController.sectionNameLabel!.text = sections[section]
//        
//        return sectionHeaderViewController.view
//    }
    
    // Get number of section headers in table
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
//    // Set number of section headers
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.sendItems.count
    }
    
//    // Set section header titles
//    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
//        return sections[section]
//    }
    
    // Return cell for row
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = self.tableView!.dequeueReusableCellWithIdentifier("sendInitiatorCell") as SendInitiatorTableViewCell
        
        cell.setUsername(sendItems[indexPath.row], color: colors[indexPath.row])
        
        return cell
    }
    
    // Handle row selection
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {

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
                    tableView.frame = CGRectMake(tableView.frame.origin.x, 0 - self.calcTopOffsetToCell(indexPath), tableView.frame.size.width, tableView.frame.size.height + 190)
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
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if cellIsSelected(indexPath) {
            return 335
        }
        
        return 65
    }
    
    // MARK: Keyboard Event Notifications
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
//        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: true)
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
//        keyboardWillChangeFrameWithNotification(notification, showsKeyboard: false)
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        

        
//        tableView?.scrollToRowAtIndexPath(<#indexPath: NSIndexPath?#>, atScrollPosition: <#UITableViewScrollPosition#>, animated: <#Bool#>)
//        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:nIndex inSection:nSectionIndex];
//        [self.tblView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

}
