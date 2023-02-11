//
//  UIApplicationExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

import UIKit

public extension UIApplication {
    var rootViewController: UIViewController? {
        #if targetEnvironment(macCatalyst)
            let window = windows.last
        #else
            let window = keyWindow
        #endif
        return window?.rootViewController
    }
}
