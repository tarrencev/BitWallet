//
//  TransactionsTableViewCell.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/23/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUser(user: String) {
        userLabel.text = user
    }
    
    func setAmount(amount: String) {
        amountLabel.text = amount
    }
    
    func setDate(date: String) {
        dateLabel.text = date
    }
    
}
