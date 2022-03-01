//
//  UIColor.swift
//  Revival
//
//  Created by phuong.doan on 5/8/21.
//

import Foundation
import UIKit

extension UIColor {
    
    static var random: UIColor {
           return UIColor(red: .random(in: 0...1),
                          green: .random(in: 0...1),
                          blue: .random(in: 0...1),
                          alpha: 1.0)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(_ strColor: String) {
        let arr = strColor.split(separator: " ")
        // console.tlog("colorFromString ", arr);
        var red: Int = 0
        var green: Int = 0
        var blue: Int = 0
        var alpha: CGFloat = 1.0
        
        if arr.count == 4 {
            red = Int(arr[1]) ?? 0
            green = Int(arr[2]) ?? 0
            blue = Int(arr[3]) ?? 0
        } else if arr.count == 5 {
            red = Int(arr[1]) ?? 0
            green = Int(arr[2]) ?? 0
            blue = Int(arr[3]) ?? 0
            
            if let doubleValue = Double(arr[4]) {
                alpha = CGFloat(doubleValue)
            }
        }
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
}
