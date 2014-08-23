//
//  SendViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/11/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendViewController: UIViewController, SendNavViewDelegate {
    
    private enum AddUserPaneState {
        case Open
        case Closed
    }
    
    private let ADD_USER_ANIMATION_DURATION = 0.3
    
    private var sendTableViewController = SendTableViewController(),
        sendNavViewController = SendNavViewController(),
        addUserPaneState = AddUserPaneState.Closed

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navbar
        sendNavViewController.delegate = self
        self.addChildViewController(sendNavViewController)
        self.view.addSubview(sendNavViewController.view)
        sendNavViewController.didMoveToParentViewController(self)
        
        // Setup tableview
        self.addChildViewController(sendTableViewController)
        self.view.addSubview(sendTableViewController.view)
        sendTableViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Public */
    func viewIsScrollingOffScreen() {
        sendTableViewController.closeSelectedCell()
        sendNavViewController.closeSearch()
    }
    
    /* Delegate Methods */
    internal func toggleAddUser() {
        
        func closeAddUserPane() {
            UIView.animateWithDuration(ADD_USER_ANIMATION_DURATION, animations: {
                self.sendNavViewController.view.frame.size.height = 44
                self.sendTableViewController.view.frame.origin.y = self.sendTableViewController.view.frame.origin.y - 120
            })
            
            addUserPaneState = .Closed
        }
        
        func openAddUserPane() {
            UIView.animateWithDuration(ADD_USER_ANIMATION_DURATION, animations: {
                self.sendNavViewController.view.frame.size.height = 120
                self.sendTableViewController.view.frame.origin.y = self.sendTableViewController.view.frame.origin.y + 120
            })
            
            addUserPaneState = .Open
        }
        
        addUserPaneState == .Open ? closeAddUserPane() : openAddUserPane()
    }
}
