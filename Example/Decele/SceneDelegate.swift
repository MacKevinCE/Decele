//
//  SceneDelegate.swift
//  Decele_Example
//
//  Created by Mc Kevin on 30/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupView(windowScene)
    }

    private func setupView(_ windowScene: UIWindowScene) {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return }
        window.rootViewController = UINavigationController(rootViewController: .main)
        window.windowScene = windowScene
        window.makeKeyAndVisible()
    }
}
