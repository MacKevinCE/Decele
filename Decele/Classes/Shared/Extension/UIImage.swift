//
//  UIImage.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import Foundation

extension UIImage {
    convenience init?(name: String, in bundle: Bundle?) {
        let traitCollection = UITraitCollection(displayScale: 3)
        self.init(named: name, in: bundle, compatibleWith: traitCollection)
    }
}
