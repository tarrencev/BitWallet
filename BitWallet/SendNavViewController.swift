//
//  SendNavViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/11/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendNavViewController: UIViewController, UITextFieldDelegate {
    
    let searchTextField = UITextField(),
        addCloseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup add user button
        addCloseButton.frame = CGRectMake(273, -8, 40, 52)
        addCloseButton.addTarget(self, action: "addUser", forControlEvents: .TouchUpInside)

        addCloseButton.setTitle("+", forState: UIControlState.Normal)
        addCloseButton.titleLabel.font = UIFont(name: "Helvetica", size: 34)
        self.view.addSubview(addCloseButton)
        
        // Setup search texfield
        searchTextField.delegate = self
        searchTextField.frame = CGRectMake(35, 0, 250, 44)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .Center
        searchTextField.textColor = .whiteColor()
        self.view.addSubview(searchTextField)
        
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, CGFloat(44))
        self.view.backgroundColor = Utilities.baseColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeSearch() {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
    }
    
    func addUser() {
        println("add user")
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        addCloseButton.removeTarget(self, action: "addUser", forControlEvents: .TouchUpInside)
        addCloseButton.addTarget(self, action: "closeSearch", forControlEvents: .TouchUpInside)

        UIView.animateWithDuration(0.3, animations: {
            self.addCloseButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / -4))
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        addCloseButton.removeTarget(self, action: "closeSearch", forControlEvents: .TouchUpInside)
        addCloseButton.addTarget(self, action: "addUser", forControlEvents: .TouchUpInside)
        
        UIView.animateWithDuration(0.3, animations: {
            self.addCloseButton.transform = CGAffineTransformMakeRotation(CGFloat(0))
        })
    }

}
