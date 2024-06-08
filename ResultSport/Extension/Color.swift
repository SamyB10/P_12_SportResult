//
//  Color.swift
//  
//
//  Created by Samy Boussair on 02/08/2023.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    // Color TabBar and nav
    public static let mainColor = UIColor.rgb(r: 9, g: 32, b: 63, a: 1)
    public static let cellColor = UIColor.rgb(r: 83, g: 120, b: 149, a: 1)
}

extension CGColor {

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> CGColor {
        return CGColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

    // Color TabBar and nav
    public static let mainColor = UIColor.rgb(r: 239, g: 212, b: 174, a: 1)
}


