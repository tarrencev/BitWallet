//
//  Utilities.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

let colors = [0x3498DB, 0x8E44AD, 0xF1C40F, 0xF39C12, 0xC0392B, 0x2C3E50, 0x16A085]

class Utilities: NSObject {
    
    class func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
    
    class func baseColor() -> UIColor {
        return colorize(0x3498DB, alpha: 1)
    }
    
    class func getColorForRow(row: Int) -> UIColor {
        return colorize(colors[row % colors.count], alpha: 1)
    }
}