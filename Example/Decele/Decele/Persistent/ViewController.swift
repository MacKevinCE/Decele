//
//  ViewController.swift
//  Decele
//
//  Created by Hermes Mac Kevin Cabanillas Encarnación on 01/10/2023.
//  Copyright (c) 2023 Hermes Mac Kevin Cabanillas Encarnación. All rights reserved.
//

import Decele
import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Persistent.token.value = "Holaa"
        Persistent.removeAllKeysUserDefaults()
        print(Persistent.token.value ?? "nada")
        print(Persistent.prefix)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Persistent {
    static var token = PersistentOptional<String>(.userDefaults(key: "Token"))
    static var user = PersistentData<String>(.keychain(key: "User"), defaultValue: "kevin")
}
