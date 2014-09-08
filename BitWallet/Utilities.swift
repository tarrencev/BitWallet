//
//  Utilities.swift
//  BitWallet
//
//  Created by Tarrence van As on 8/3/14.
//  Copyright (c) 2014 tva. All rights reserved.
//

import UIKit

let colors = [0x3498DB, 0x8E44AD, 0x42586E, 0x2C3E50]

class Utilities {
    
    class func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0,
            green = Double((hex & 0xFF00) >> 8) / 255.0,
            blue = Double((hex & 0xFF)) / 255.0,
            color = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }

    class func baseColor() -> UIColor {
        let rand = Int(2)

        return colorize(colors[rand], alpha: 1)
    }
    //0x16A085
    class func secondaryColor() -> UIColor {
        return colorize(0x2C3E50, alpha: 1)
    }
    
    class func getColorForIndex(index: Int) -> UIColor {
        return colorize(colors[index % colors.count], alpha: 1)
    }
}

extension Dictionary /* <KeyType, ValueType> */ {
    
    func mapKeys<U> (transform: Key -> U) -> Array<U> {
        var results: Array<U> = []
        for k in self.keys {
            results.append(transform(k))
        }
        return results
    }
    
    func mapValues<U> (transform: Value -> U) -> Array<U> {
        var results: Array<U> = []
        for v in self.values {
            results.append(transform(v))
        }
        return results
    }
    
    func map<U> (transform: Value -> U) -> Array<U> {
        return self.mapValues(transform)
    }
    
    func map<U> (transform: (Key, Value) -> U) -> Array<U> {
        var results: Array<U> = []
        for k in self.keys {
            results.append(transform(k as Key, self[ k ] as Value!))
        }
        return results
    }
    
    func map<K: Hashable, V> (transform: (Key, Value) -> (K, V)) -> Dictionary<K, V> {
        var results: Dictionary<K, V> = [:]
        for k in self.keys {
            if let value = self[ k ] {
                let (u, w) = transform(k, value)
                results.updateValue(w, forKey: u)
            }
        }
        return results
    }
    
}