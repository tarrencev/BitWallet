//
//  SendTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class SendTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    func setUsername(usernameString: String, color: Int) {
        self.backgroundColor = Utilities.colorize(color, alpha: 1)
        usernameLabel.text = usernameString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
