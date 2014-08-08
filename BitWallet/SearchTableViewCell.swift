//
//  SearchTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/7/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    var closeButton = CloseButton()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Utilities.baseColor()
        
        self.closeButton.addTarget(self, action: "closeSearch", forControlEvents: UIControlEvents.TouchUpInside)
        self.closeButton.frame = CGRectMake(275 + 50, 0, 44, 38)
        self.addSubview(self.closeButton)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func closeSearch() {
        self.searchTextField.resignFirstResponder()

    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        UIView.animateWithDuration(0.3, animations: {
            var buttonCenter = self.closeButton.center
            buttonCenter.x = buttonCenter.x - 50
            self.closeButton.center = buttonCenter
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        UIView.animateWithDuration(0.3, animations: {
            var buttonCenter = self.closeButton.center
            buttonCenter.x = buttonCenter.x + 50
            self.closeButton.center = buttonCenter
        })
    }
}
