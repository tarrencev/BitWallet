//
//  SearchTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/7/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Utilities.colorize(0x3498DB, alpha: 1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
