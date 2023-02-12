//
//  UIViewControllerExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 12/02/23.
//

import UIKit

public extension UIViewController {
    static func instantiatedFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: Self.nameClass, bundle: Bundle.main)
        guard let view = storyboard.instantiateInitialViewController() as? Self else {
            fatalError()
        }
        return view
    }
}
