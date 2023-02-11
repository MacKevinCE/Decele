//
//  UIButtonExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 5/02/23.
//

import UIKit

public extension UIButton {
    @IBInspectable
    var backgroundImageForDisabled: UIImage? {
        get {
            return backgroundImage(for: .disabled)
        }
        set {
            setBackgroundImage(newValue, for: .disabled)
        }
    }

    @IBInspectable
    var backgroundImageForHighlighted: UIImage? {
        get {
            return backgroundImage(for: .highlighted)
        }
        set {
            setBackgroundImage(newValue, for: .highlighted)
        }
    }

    @IBInspectable
    var backgroundImageForNormal: UIImage? {
        get {
            return backgroundImage(for: .normal)
        }
        set {
            setBackgroundImage(newValue, for: .normal)
        }
    }

    @IBInspectable
    var backgroundImageForSelected: UIImage? {
        get {
            return backgroundImage(for: .selected)
        }
        set {
            setBackgroundImage(newValue, for: .selected)
        }
    }

    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    func setBackgroundImageForAllStates(_ image: UIImage?) {
        states.forEach { setBackgroundImage(image, for: $0) }
    }
}
