//
//  SendSectionHeaderView.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/11/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendSectionHeaderView: UIView {
    
    let sectionTitleLabel: UILabel?
    
    required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Utilities.secondaryColor()
        
        sectionTitleLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        sectionTitleLabel?.textColor = .whiteColor()
        sectionTitleLabel?.textAlignment = .Center
        
        self.addSubview(sectionTitleLabel!)
    }
    
    func setSectionTitle(title: String) {
        sectionTitleLabel!.text = title
    }
}
