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
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var bootstrapIcons: UIImageView!
    @IBOutlet var fontawesomeBrands: UIImageView!
    @IBOutlet var fontawesomeFreeSolid: UIImageView!
    @IBOutlet var fontawesomeFreeRegular: UIImageView!
    @IBOutlet var materialIconsOutlined: UIImageView!
    @IBOutlet var materialIconsFilled: UIImageView!
    @IBOutlet var materialIconsSharp: UIImageView!
    @IBOutlet var materialIconsRounded: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    func setupView() {
        titleLabel.text = "Holaa@"
        titleLabel.font = FontawesomeFree.font(ofSize: 50, style: .regular)

        bootstrapIcons.image(name: BootstrapIcons.bi3CircleFill, textColor: .blue)
        fontawesomeBrands.image(name: FontawesomeBrands.fabVk, textColor: .red)
        fontawesomeFreeSolid.image(name: FontawesomeFree.fafCopyright, style: .solid, textColor: .red)
        fontawesomeFreeRegular.image(name: FontawesomeFree.fafCopyright, style: .regular, textColor: .red)
        materialIconsOutlined.image(name: MaterialIcons.miRocketLaunch, style: .outlined, textColor: .red)
        materialIconsFilled.image(name: MaterialIcons.miRocketLaunch, style: .filled, textColor: .red)
        materialIconsSharp.image(name: MaterialIcons.miRocketLaunch, style: .sharp, textColor: .red)
        materialIconsRounded.image(name: MaterialIcons.miRocketLaunch, style: .rounded, textColor: .red)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
