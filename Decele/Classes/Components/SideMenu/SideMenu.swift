//
//  SideMenu.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/26/21.
//

import SideMenu
import UIKit

public final class SideMenu: SideMenuNavigationController {
    public var config: SideMenuSetting = .shared {
        willSet {
            if let viewController = topViewController as? SideMenuTableViewController {
                viewController.config = newValue
            }
        }
    }

    public var data: [AttributedStringConvertible] = [] {
        willSet {
            if let viewController = topViewController as? SideMenuTableViewController {
                viewController.data = newValue
            }
        }
    }

    weak var delegateAction: SideMenuActionDelegate? {
        willSet {
            if let viewController = topViewController as? SideMenuTableViewController {
                viewController.delegateAction = newValue
            }
        }
    }

    public convenience init(delegateAction: SideMenuActionDelegate? = nil, data: [AttributedStringConvertible], settings: SideMenuSettings = SideMenuSettings(), config: SideMenuSetting = .shared, sideMenuDelegate: SideMenuNavigationControllerDelegate? = nil) {
        let view = SideMenuTableViewController()
        view.tableView.bounces = false
        view.delegateAction = delegateAction
        view.data = data
        view.config = config

        self.init(rootViewController: view, settings: settings)
        self.delegateAction = delegateAction
        self.data = data
        self.config = config
        self.sideMenuDelegate = sideMenuDelegate
    }

    public convenience init(delegateAction: SideMenuActionDelegate? = nil, data: [AttributedStringConvertible], presentationStyle: SideMenuPresentationStyle, config: SideMenuSetting = .shared, sideMenuDelegate: SideMenuNavigationControllerDelegate? = nil) {
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        self.init(delegateAction: delegateAction, data: data, settings: settings, config: config, sideMenuDelegate: sideMenuDelegate)
    }
}
