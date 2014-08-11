//
//  SendInitiatorTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

protocol SendInitiatorCellDelegate {
    func closeCell(cell: SendInitiatorTableViewCell)
}

class SendInitiatorTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    var closeButton = CloseButton(),
        delegate: SendInitiatorCellDelegate?
    
    @IBOutlet weak var sendButtonHighlight: UIView!
    var sendButtonHighlightIsLeft: Bool = false

    
    @IBAction func sendButton(sender: AnyObject) {
        toggleSendButtonHightlight()
    }
    
    @IBAction func requestButton(sender: AnyObject) {
        toggleSendButtonHightlight()
    }
    
    func toggleSendButtonHightlight() {
        
        let x: CGFloat = sendButtonHighlightIsLeft ? self.sendButtonHighlight.frame.size.width : 0,
            y = self.sendButtonHighlight.frame.origin.y,
            width = self.sendButtonHighlight.frame.size.width,
            height = self.sendButtonHighlight.frame.size.height
        
        UIView.animateWithDuration(0.3, animations: {
            self.sendButtonHighlight.frame = CGRectMake(x, y, width, height)
            }, completion: {
                finished in
                self.sendButtonHighlightIsLeft = !self.sendButtonHighlightIsLeft
        })
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        println("done")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.closeButton.addTarget(self, action: "closeBtnPress", forControlEvents: UIControlEvents.TouchUpInside)
        self.closeButton.frame = CGRectMake(265 + 70, 0, 65, 65)
        self.addSubview(closeButton)
    }
    
    func open() {
        UIView.animateWithDuration(0.3, animations: {
            var buttonCenter = self.closeButton.center
            buttonCenter.x = buttonCenter.x - 70
            self.closeButton.center = buttonCenter
        })
        amountTextfield.becomeFirstResponder()
    }
    
    func closeBtnPress() {
        delegate?.closeCell(self)
    }
    
    func close() {
        UIView.animateWithDuration(0.3, animations: {
            var buttonCenter = self.closeButton.center
            buttonCenter.x = buttonCenter.x + 70
            self.closeButton.center = buttonCenter
        })
        amountTextfield.text = ""
        noteTextField.text = ""
        amountTextfield.resignFirstResponder()
        noteTextField.resignFirstResponder()
    }

    func setUsername(usernameString: String) {
        usernameLabel.text = usernameString
    }
    
    func setColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let text: String = textField.text
        if textField.tag == 100 && countElements(text) == 0 {
            textField.text = "฿" + string
            
            return false
        }
        
        return true
    }
}
