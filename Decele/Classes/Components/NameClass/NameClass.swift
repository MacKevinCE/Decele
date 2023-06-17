//
//  NameClassView.swift
//  DailyRoutine
//
//  Created by Mc Kevin on 14/01/23.
//

import Foundation

import UIKit

// MARK: - NameClass
public protocol NameClass: AnyObject {
    static var nameClass: String { get }
}

public extension NameClass {
    static var nameClass: String {
        String(describing: self)
    }
}

// MARK: - UIView + NameClass
extension UIView: NameClass {}

// MARK: - UIViewController + NameClass
extension UIViewController: NameClass {}
