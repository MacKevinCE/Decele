//
//  UITableView.swift
//  Chuck
//
//  Created by Mc Kevin on 3/11/22.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nibName = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: nibName)
    }

    func dequeueReusableCell<T: UITableViewCell>(with _: T.Type, for indexPath: IndexPath, isRegistered: Bool = false) -> T {
        let nibName = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? T else {
            if !isRegistered {
                register(T.self)
                return dequeueReusableCell(with: T.self, for: indexPath, isRegistered: true)
            } else {
                fatalError("Couldn't find UITableViewCell for \(nibName), make sure the cell is registered with table view")
            }
        }
        return cell
    }

    func reloadRowsVisiblesCell(with animation: UITableView.RowAnimation = .automatic) {
        reloadRows(at: indexPathsForVisibleRows ?? [], with: animation)
    }
}
