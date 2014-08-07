//
//  SendInitiatorTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendInitiatorTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBAction func sendButton(sender: AnyObject) {
        println("Send")
        
    
    }
    
    @IBAction func requestButton(sender: AnyObject) {
        println("Request")
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        println("done")
    }
    
    var cellHeight: CGFloat {
    get {
        return self.bounds.height
    }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        var closeButton = UIButton()
//        closeButton.frame = CGRectMake(260, 0, 65, 65)
//        closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / -4))
//        closeButton.setTitle("+", forState: UIControlState.Normal)
//        closeButton.titleLabel.font = UIFont(name: "Helvetica", size: 50)
//        self.addSubview(closeButton)
    }

    
    func setUsername(usernameString: String, color: Int) {
        self.backgroundColor = Utilities.colorize(color, alpha: 1)
        usernameLabel.text = usernameString
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let text: String = textField.text
        println(textField.text)
        if countElements(text) == 0 {
            textField.text = "฿" + string
            
            return false
        }
        
        return true
    }
}
