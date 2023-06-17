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
    
    @IBOutlet weak var titleLabel: UILabel!

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
        
        titleLabel.text = "Holaa@"
        titleLabel.font = FontawesomeFree.font(ofSize: 50, style: .regular)
        
        bootstrapIcons.image = BootstrapIcons.image(name: .biAlarm, style: .regular, textColor: .red, size: bootstrapIcons.size)
        fontawesomeBrands.image = FontawesomeBrands.image(name: .fabVk, style: .brands, textColor: .red, size: fontawesomeBrands.size)
        fontawesomeFreeSolid.image = FontawesomeFree.image(name: .fafCopyright, style: .solid, textColor: .red, size: fontawesomeFreeSolid.size)
        fontawesomeFreeRegular.image = FontawesomeFree.image(name: .fafCopyright, style: .regular, textColor: .red, size: fontawesomeFreeRegular.size)
        materialIconsOutlined.image = MaterialIcons.image(name: .miRocket_Launch, style: .outlined, textColor: .red, size: materialIconsOutlined.size)
        materialIconsFilled.image = MaterialIcons.image(name: .miRocket_Launch, style: .filled, textColor: .red, size: materialIconsFilled.size)
        materialIconsSharp.image = MaterialIcons.image(name: .miRocket_Launch, style: .sharp, textColor: .red, size: materialIconsSharp.size)
        materialIconsRounded.image = MaterialIcons.image(name: .miRocket_Launch, style: .rounded, textColor: .red, size: materialIconsRounded.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
