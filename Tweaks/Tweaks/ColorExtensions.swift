//
//  ColorExtensions.swift
//  Tweaks
//
//  Created by dasdom on 25.10.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

//import Foundation
import UIKit

extension UIColor {
    
    class func colorFromHex(hexString: String) -> UIColor {
        let scanner = NSScanner(string: hexString)
        
        scanner.charactersToBeSkipped = NSCharacterSet.alphanumericCharacterSet().invertedSet
        
        var value = UInt32()
        scanner.scanHexInt(&value)
        
        let red: CGFloat = CGFloat((value & 0xFF0000) >> 16) / CGFloat(255.0)
        let green: CGFloat = CGFloat((value & 0xFF00) >> 8) / CGFloat(255.0)
        let blue: CGFloat = CGFloat((value & 0xFF)) / CGFloat(255.0)
        
        println("red \(red) green \(green) blue \(blue)")
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func hexString() -> String {
        var redComponent = CGFloat()
        var greenComponent = CGFloat()
        var blueComponent = CGFloat()
        var alphaComponent = CGFloat()
        
        getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)

//        println("red \(redComponent) green \(greenComponent) blue \(blueComponent)")

        let redInt = (UInt32(redComponent*255)) << 16
        let greenInt = (UInt32(greenComponent*255)) << 8
        let blueInt = UInt32(blueComponent*255)
        
//        println("color \(self)")
//        println("red \(redInt) green \(greenInt) blue \(blueInt)")
        
        let colorInt = redInt+greenInt+blueInt
        let colorString = NSString(format: "%06X", colorInt) as String
        
        return colorString
    }
    
}
