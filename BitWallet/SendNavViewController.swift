//
//  SendNavViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/11/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

protocol SendNavViewDelegate {
    func toggleAddUser()
}

class SendNavViewController: UIViewController, UITextFieldDelegate {
    
    let searchTextField = UITextField(),
        addCloseButton = UIButton(),
        nearbyButton = UIButton(),
        scanQrButton = UIButton(),
        enterInfoButton = UIButton()
    
    var delegate: SendNavViewDelegate?,
        plusButtonState = PlusButtonState.Add

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup add user button
        addCloseButton.frame = CGRectMake(273, -8, 40, 52)
        addCloseButton.addTarget(self, action: "addUser", forControlEvents: .TouchUpInside)

        addCloseButton.setTitle("+", forState: .Normal)
        addCloseButton.titleLabel.font = UIFont(name: "Helvetica", size: 34)
        self.view.addSubview(addCloseButton)
        
        // Setup search texfield
        searchTextField.delegate = self
        searchTextField.frame = CGRectMake(35, 0, 250, 44)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .Center
        searchTextField.textColor = .whiteColor()
        self.view.addSubview(searchTextField)
        
        // Setup toggle nearby button
        nearbyButton.frame = CGRectMake(0, 44, 106, 120)
        nearbyButton.setTitle("Nearby", forState: .Normal)
        nearbyButton.titleLabel.font = UIFont(name: "Helvetica", size: 18)
        nearbyButton.titleEdgeInsets = UIEdgeInsetsMake(65, -50, 0, 0)
        nearbyButton.setImage(UIImage(named: "nearby"), forState: .Normal)
        nearbyButton.imageEdgeInsets = UIEdgeInsetsMake(-40, 20, 0, 0)
        self.view.addSubview(nearbyButton)
        
        // Setup toggle scan QR button
        scanQrButton.frame = CGRectMake(107, 44, 106, 120)
        scanQrButton.setTitle("Scan QR", forState: .Normal)
        scanQrButton.titleLabel.font = UIFont(name: "Helvetica", size: 18)
        scanQrButton.titleEdgeInsets = UIEdgeInsetsMake(65, -50, 0, 0)
        scanQrButton.setImage(UIImage(named: "qr_code"), forState: .Normal)
        scanQrButton.imageEdgeInsets = UIEdgeInsetsMake(-40, 20, 0, 0)
        self.view.addSubview(scanQrButton)
        
        // Setup toggle enter info button
        enterInfoButton.frame = CGRectMake(214, 44, 106, 120)
        enterInfoButton.setTitle("Search", forState: .Normal)
        enterInfoButton.titleLabel.font = UIFont(name: "Helvetica", size: 18)
        enterInfoButton.titleEdgeInsets = UIEdgeInsetsMake(65, -50, 0, 0)
        enterInfoButton.setImage(UIImage(named: "search"), forState: .Normal)
        enterInfoButton.imageEdgeInsets = UIEdgeInsetsMake(-40, 20, 0, 0)
        self.view.addSubview(enterInfoButton)
        
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
        togglePlusButton()
        delegate?.toggleAddUser()
    }
    
    func togglePlusButton() {
        func rotateToAddState() {
            UIView.animateWithDuration(0.3, animations: {
                self.addCloseButton.transform = CGAffineTransformMakeRotation(CGFloat(0))
            })
            
            plusButtonState = .Add
        }
        
        func rotateToCloseState() {
            UIView.animateWithDuration(0.3, animations: {
                self.addCloseButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / -4))
            })
            
            plusButtonState = .Close
        }
        
        plusButtonState == .Add ? rotateToCloseState() : rotateToAddState()
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        addCloseButton.removeTarget(self, action: "addUser", forControlEvents: .TouchUpInside)
        addCloseButton.addTarget(self, action: "closeSearch", forControlEvents: .TouchUpInside)
        
        togglePlusButton()
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        addCloseButton.removeTarget(self, action: "closeSearch", forControlEvents: .TouchUpInside)
        addCloseButton.addTarget(self, action: "addUser", forControlEvents: .TouchUpInside)
        
        togglePlusButton()
    }
    
    enum PlusButtonState {
        case Add
        case Close
    }

}
