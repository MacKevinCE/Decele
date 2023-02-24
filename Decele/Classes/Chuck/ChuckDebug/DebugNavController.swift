//
//  DebugNavController.swift
//  Decele
//
//  Created by Mc Kevin on 7/11/22.
//

import UIKit

class DebugNavController: UINavigationController {
    func getChuckDebugViewController() -> ChuckDebugViewController? {
        return viewControllers.firstType()
    }

    func getChuckDebugDetailViewController() -> ChuckDebugDetailViewController? {
        return viewControllers.firstType()
    }
}
