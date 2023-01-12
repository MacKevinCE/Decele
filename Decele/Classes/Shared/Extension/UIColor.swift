//
//  UIColor.swift
//  Chuck
//
//  Created by Mc Kevin on 13/07/22.
//

import Foundation

extension UIColor {
    func setAlpha(_ alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var preAlpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &preAlpha)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
