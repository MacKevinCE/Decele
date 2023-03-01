//
//  ChuckDebugAssembly.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

// MARK: - ChuckDebugAssembly
class ChuckDebugAssembly {
    static func build() -> ChuckDebugViewController {
        let bundle = Bundle(for: ChuckDebugViewController.self)
        let storyboard = UIStoryboard(name: "ChuckDebug", bundle: bundle)
        let view = storyboard.instantiateInitialViewController() as! ChuckDebugViewController
        return view
    }
}

// MARK: - ChuckDebugDetailAssembly
enum ChuckDebugDetailAssembly {
    static func build(chuck: OutputClass) -> ChuckDebugDetailViewController {
        let bundle = Bundle(for: ChuckDebugDetailViewController.self)
        let storyboard = UIStoryboard(name: "ChuckDebug", bundle: bundle)
        let view = storyboard.instantiateViewController(withIdentifier: "ChuckDebugDetailViewController") as! ChuckDebugDetailViewController
        view.chuck = chuck
        return view
    }
}
