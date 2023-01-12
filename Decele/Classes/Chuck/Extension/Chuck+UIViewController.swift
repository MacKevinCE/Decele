//
//  UIViewController.swift
//  Decele
//
//  Created by Mc Kevin on 11/01/23.
//

import UIKit

extension UIViewController {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake, Chuck.typeOpen == .shake || Chuck.typeOpen == .all {
            Chuck.openChuckDebug()
        }
    }
}
