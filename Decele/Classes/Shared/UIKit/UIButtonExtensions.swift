//
//  UIButtonExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 5/02/23.
//

import UIKit

public extension UIButton {
    var backgroundImageForDisabled: UIImage? {
        get {
            backgroundImage(for: .disabled)
        }
        set {
            setBackgroundImage(newValue, for: .disabled)
        }
    }

    var backgroundImageForHighlighted: UIImage? {
        get {
            backgroundImage(for: .highlighted)
        }
        set {
            setBackgroundImage(newValue, for: .highlighted)
        }
    }

    var backgroundImageForNormal: UIImage? {
        get {
            backgroundImage(for: .normal)
        }
        set {
            setBackgroundImage(newValue, for: .normal)
        }
    }

    var backgroundImageForSelected: UIImage? {
        get {
            backgroundImage(for: .selected)
        }
        set {
            setBackgroundImage(newValue, for: .selected)
        }
    }

    private var states: [UIControl.State] {
        [.normal, .selected, .highlighted, .disabled]
    }

    func setBackgroundImageForAllStates(_ image: UIImage?) {
        states.forEach { setBackgroundImage(image, for: $0) }
    }
}
