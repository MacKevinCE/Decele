//
//  UIApplicationExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

import UIKit

public extension UIApplication {
    var rootViewController: UIViewController? {
        return windows.last?.rootViewController
    }
}
