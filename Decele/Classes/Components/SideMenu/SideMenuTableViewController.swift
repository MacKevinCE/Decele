//
//  SideMenuTableViewController.swift
//  InglesYa
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/26/21.
//

import SideMenu
import UIKit

public protocol SideMenuActionDelegate: AnyObject {
    func selected(_ sender: SideMenuTableViewController, data: [AttributedStringConvertible], index: Int)
}

public class SideMenuTableViewController: UITableViewController {
    var config: ConfigSideMenu!
    var data: [AttributedStringConvertible] = []
    weak var delegateAction: SideMenuActionDelegate?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = config.backgroundColor

        tableView.reloadData()

        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }

        let imageView = UIImageView(image: config.backgroundImage)
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elem = data[indexPath.row]
        switch config.typeCell {
        case let .attributed(numberOfLines, backgroundColor):
            let cell = UITableViewCell()
            cell.textLabel?.attributedText = elem.asMutableAttributedString()
            cell.textLabel?.numberOfLines = numberOfLines
            cell.backgroundColor = backgroundColor
            return cell
        case let .cell(typeCell):
            let cell = tableView.dequeueReusableCell(with: typeCell, for: indexPath) as! SideMenuTableViewCell
            cell.seputCell(text: elem.asMutableAttributedString())
            return cell
        }
    }

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegateAction?.selected(self, data: data, index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}
