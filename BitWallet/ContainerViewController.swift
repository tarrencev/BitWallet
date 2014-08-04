//
//  ViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView?;
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create the 3 main view controllers
        var receiveViewController = ReceiveViewController(),
            sendViewController = SendViewController(),
            profileViewController = ProfileViewController()
        
        receiveViewController.view.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        sendViewController.view.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        profileViewController.view.backgroundColor = Utilities.colorize(0x2C3E50, alpha: 1)
        
        // Add each view to container view hierarchy
        self.addChildViewController(profileViewController)
        self.scrollView?.addSubview(profileViewController.view)
        profileViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(sendViewController)
        self.scrollView?.addSubview(sendViewController.view)
        sendViewController.didMoveToParentViewController(self)

        self.addChildViewController(receiveViewController)
        self.scrollView?.addSubview(receiveViewController.view)
        receiveViewController.didMoveToParentViewController(self)
        
        // Setup frames of the view controllers to align inside container
        var receiveFrame = receiveViewController.view.frame
        receiveFrame.origin.x = receiveFrame.width
        sendViewController.view.frame = receiveFrame
        
        var transactionsFrame = sendViewController.view.frame
        transactionsFrame.origin.x = 2 * transactionsFrame.width
        profileViewController.view.frame = transactionsFrame;
        
        // Set scrollView size to contain the frames
        var scrollWidth = 3 * self.view.frame.width,
            scrollHeight = self.view.frame.size.height - 20
        self.scrollView!.contentSize = CGSizeMake(scrollWidth, scrollHeight)
        self.scrollView!.setContentOffset(CGPoint(x: receiveFrame.width, y: 0), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

