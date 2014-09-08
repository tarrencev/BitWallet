//
//  TransactViewController.swift
//  BitWallet
//
//  Created by Tarrence van As on 9/2/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class TransactViewController: UIViewController, UITextFieldDelegate {
    
    private let amountView = UIView(frame: CGRectMake(0, 100, 320, 100)),
        currency = Currency.BTC
    
    private func createTransactInputAccessoryView() -> UIView {
        let transactInputAccessoryView = UIView(frame: CGRectMake(0, 0, 320, 50)),
            requestButton = UIButton(frame: CGRectMake(0, 0, 160, 50)),
            sendButton = UIButton(frame: CGRectMake(161, 0, 159, 50)),
            centerBorder = UIView(frame: CGRectMake(requestButton.frame.size.width, 0, 0.25, transactInputAccessoryView.frame.size.height)),
            bottomBorder = UIView(frame: CGRectMake(0, transactInputAccessoryView.frame.size.height, transactInputAccessoryView.frame.size.width, 0.5)),
            topBorder = UIView(frame: CGRectMake(0, 0, transactInputAccessoryView.frame.size.width, 0.5))
        
//        CGContextSetShouldAntialias(ctx, NO)
//        CGContextSetShouldAntialias(<#context: CGContext!#>, <#shouldAntialias: Bool#>)
        
        centerBorder.backgroundColor = Utilities.colorize(0xb5b5b5, alpha: 1)
        bottomBorder.backgroundColor = Utilities.colorize(0xb5b5b5, alpha: 1)
        topBorder.backgroundColor = Utilities.colorize(0xb5b5b5, alpha: 1)
        
        requestButton.setTitle("Request", forState: UIControlState.Normal)
        requestButton.tag = 300
        requestButton.titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        requestButton.backgroundColor = Utilities.colorize(0xfcfcfc, alpha: 1)
        requestButton.setTitleColor(.blackColor(), forState: .Normal)
        requestButton.addTarget(self, action: Selector("createTransaction:"), forControlEvents: UIControlEvents.TouchUpInside)

        sendButton.setTitle("Send", forState: UIControlState.Normal)
        sendButton.tag = 301
        sendButton.titleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        sendButton.backgroundColor = Utilities.colorize(0xfcfcfc, alpha: 1)
        sendButton.setTitleColor(.blackColor(), forState: .Normal)
        sendButton.addTarget(self, action: Selector("createTransaction:"), forControlEvents: UIControlEvents.TouchUpInside)

        transactInputAccessoryView.addSubview(requestButton)
        transactInputAccessoryView.addSubview(sendButton)
        transactInputAccessoryView.addSubview(centerBorder)
        transactInputAccessoryView.addSubview(bottomBorder)
        transactInputAccessoryView.addSubview(topBorder)
        
        return transactInputAccessoryView
    }
    
    func createTransaction(sender: AnyObject) {
        let button = sender as UIButton
        
        switch (button.tag) {
        case 300:
            println("request")
            
        case 301:
            println("send")
        default:
            println("wut")
        }
    }
    
    private func createAmountView() {
        
        let amountTextField = UITextField(frame: CGRectMake(0, 0, 320, 100)),
            currencySwitchButton = UIButton(frame: CGRectMake(0, 0, 320, 100))
        
        currencySwitchButton.backgroundColor = .clearColor();
        currencySwitchButton.addTarget(self, action: "switchCurrency", forControlEvents: UIControlEvents.AllTouchEvents)
        
        amountTextField.placeholder = "฿0"
        amountTextField.tag = 500
        amountTextField.textAlignment = .Center
        amountTextField.tintColor = .clearColor()
        amountTextField.textColor = .whiteColor()
        amountTextField.keyboardType = UIKeyboardType.DecimalPad
        amountTextField.font = UIFont(name: "HelveticaNeue", size: 80)
        amountTextField.autoresizingMask = .FlexibleWidth | .FlexibleHeight
//        amountTextField.becomeFirstResponder()
        amountTextField.inputAccessoryView = createTransactInputAccessoryView()
        amountTextField.delegate = self
        
        amountView.addSubview(amountTextField)
        amountView.addSubview(currencySwitchButton)
    }
    
    private func createHeaderView() -> UIView {
        let navBar = UIView(frame: CGRectMake(0, 0, 320, 50)),
            bankButton = UIButton(frame: CGRectMake(275, 9, 32, 32)),
            receiveBitcoinButton = UIButton(frame: CGRectMake(15, 9, 32, 32)),
            titleLabel = UILabel(frame: CGRectMake(47, 0, 228, 50))
        
        navBar.backgroundColor = Utilities.colorize(0x35485c, alpha: 1)
        bankButton.setBackgroundImage(UIImage(named: "wallet"), forState: UIControlState.Normal)
        receiveBitcoinButton.setBackgroundImage(UIImage(named: "cash_receiving"), forState: UIControlState.Normal)
        titleLabel.text = "Guap"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = .whiteColor()
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        
        navBar.addSubview(bankButton)
        navBar.addSubview(receiveBitcoinButton)
        navBar.addSubview(titleLabel)
        return navBar
    }
    
    func switchCurrency() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAmountView()
        
        self.view.addSubview(amountView)
        self.view.addSubview(createHeaderView())

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIsScrollingOffScreen() {
        self.view.endEditing(true)
        println("scrolling off screen")
    }
    
    func viewIsScrollingOnScreen() {
        println("scrolling on screen")
        amountView.viewWithTag(500)?.becomeFirstResponder()
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let text: String = textField.text
        if countElements(text) == 0 {
            textField.text = "฿" + string
            
            return false
        }
        
        return true
    }
    
    private enum Currency {
        case USD
        case BTC
    }

}
