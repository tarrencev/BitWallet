//
//  CloseButton.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/7/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    override func drawRect(rect: CGRect)
    {
        self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / -4))
        self.setTitle("+", forState: UIControlState.Normal)
        self.titleLabel.font = UIFont(name: "Helvetica", size: 30)
    }
}
