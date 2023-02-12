//
//  UIColorExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 13/07/22.
//

import SwifterSwift

public extension UIColor {
    func setAlpha(_ alpha: CGFloat) -> UIColor {
        let components = cgFloatComponents
        return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
}
