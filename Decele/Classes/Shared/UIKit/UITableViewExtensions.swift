//
//  UITableViewExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 4/02/23.
//

import SwifterSwift
import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else { return nil }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, isRegistered: Bool = false) -> T {
        let identifier = String(describing: name)
        guard let cell: T = dequeueReusableCell() else {
            if isRegistered {
                fatalError("UITableViewCell identifier: \(identifier) is not registered")
            } else {
                register(cellWithClass: name)
                guard let cell: T = dequeueReusableCell() else {
                    register(nibWithCellClass: name)
                    guard let cell: T = dequeueReusableCell() else {
                        fatalError("UITableViewCell identifier: \(identifier) not possible to register")
                    }
                    return cell
                }
                return cell
            }
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(isRegistered: Bool = false) -> T {
        dequeueReusableCell(withClass: T.self, isRegistered: isRegistered)
    }

    func reloadRowsVisiblesCell(with animation: UITableView.RowAnimation = .automatic) {
        reloadRows(at: indexPathsForVisibleRows ?? [], with: animation)
    }
}
