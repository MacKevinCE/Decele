//
//  NameClassView.swift
//  DailyRoutine
//
//  Created by Mc Kevin on 14/01/23.
//

import Foundation

import UIKit

// MARK: - NameClass
protocol NameClass: AnyObject {}

extension NameClass {
    static var nameClass: String {
        return String(describing: self)
    }
}

// MARK: - UIView + NameClass
extension UIView: NameClass {}

// MARK: - UIViewController + NameClass
extension UIViewController: NameClass {}
