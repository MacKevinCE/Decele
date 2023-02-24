//
//  Button.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/16/21.
//

import SnapKit
import UIKit

// MARK: - ButtonDelegate
@objc public protocol ButtonDelegate {
    @objc optional func button(_ button: Button, changeStateWith currentState: Int, previousState: Int)
    @objc optional func button(_ button: Button, initialState currentState: Int)
}

// MARK: - Button
public class Button: UIButton {
    private var activityIndicator: UIActivityIndicatorView?

    public var getActivityIndicator: UIActivityIndicatorView? {
        return activityIndicator
    }

    public var delegateButton: ButtonDelegate? {
        willSet {
            newValue?.button?(self, initialState: currentState)
        }
    }

    public var numberStates: Int {
        get {
            return _numberStates
        }
        set {
            _numberStates = max(0, newValue)
        }
    }

    private var _numberStates: Int = 0 {
        didSet {
            currentState = 0
        }
    }

    public var getCurrentState: Int {
        return currentState
    }

    private var currentState: Int = 0 {
        didSet {
            delegateButton?.button?(self, changeStateWith: currentState, previousState: oldValue)
        }
    }

    public func previousState(step: Int = 1) {
        setState(to: currentState - step)
    }

    public func nextState(step: Int = 1) {
        setState(to: currentState + step)
    }

    public func setState(to state: Int) {
        let newState = state % numberStates
        currentState = (newState >= 0) ? newState : numberStates + newState
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public convenience init(_ numberStates: Int) {
        self.init(frame: .infinite)
        self.numberStates = numberStates
    }

    override public var isEnabled: Bool {
        willSet {
            super.isEnabled = newValue
        }
    }

    private func createActivityIndicator() {
        guard activityIndicator == nil else { return }
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.isUserInteractionEnabled = false
        addSubview(activityIndicator!)
        activityIndicator?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public var hasActivityIndicator: Bool = false {
        willSet {
            isUserInteractionEnabled = !newValue
            createActivityIndicator()
            newValue ? activityIndicator?.startAnimating() : activityIndicator?.stopAnimating()
            activityIndicator?.isHidden = !newValue
        }
    }
}
