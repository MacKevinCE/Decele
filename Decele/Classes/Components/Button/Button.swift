//
//  Button.swift
//  SwiftyComponents
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/16/21.
//

import UIKit

public protocol ButtonDelegate {
    func button(_ button: Button, changeStateWith currentState: Int?, lastState: Int?)
}

public class Button: UIButton {
    private var _rotate: CGFloat = .zero

    @IBInspectable var rotate: CGFloat {
        get { return _rotate }
        set {
            _rotate = newValue
            self.rotate(byAngle: newValue, ofType: .degrees)
        }
    }

    private var _activityIndicator: UIActivityIndicatorView?

    public var activityIndicator: UIActivityIndicatorView? {
        return _activityIndicator
    }

    public var delegate: ButtonDelegate? {
        willSet {
            if _currentState != nil {
                newValue?.button(self, changeStateWith: _currentState, lastState: nil)
            }
        }
    }

    public var numberStates: Int? {
        get {
            return _numberStates
        }
        set {
            if let value = newValue, value > 0 {
                _numberStates = value
            } else {
                _numberStates = nil
            }
        }
    }

    private var _numberStates: Int? {
        didSet {
            _currentState = (numberStates != nil) ? 0 : nil
        }
    }

    public var currentState: Int? {
        return _currentState
    }

    private var _currentState: Int? {
        didSet {
            if _currentState != nil || oldValue != nil {
                delegate?.button(self, changeStateWith: _currentState, lastState: oldValue)
            }
        }
    }

    public func previousState() {
        if let state = _currentState {
            let newState = (state - 1) % (numberStates ?? 0)
            _currentState = (newState >= 0) ? newState : (numberStates ?? 0) + newState
        }
    }

    public func nextState() {
        if let state = _currentState {
            let newState = (state + 1) % (numberStates ?? 0)
            _currentState = newState
        }
    }

    public func setState(to state: Int) {
        if _currentState != nil {
            let newState = state % (numberStates ?? 0)
            _currentState = (newState >= 0) ? newState : (numberStates ?? 0) + newState
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        customBuilder()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        customBuilder()
    }

    public convenience init(_ numberStates: Int) {
        self.init(frame: .infinite)
        customBuilder()
        self.numberStates = numberStates
    }

    func customBuilder() {
        hasActivityIndicator = false
    }

    override public var isEnabled: Bool {
        willSet {
            super.isEnabled = newValue
        }
    }

    private func createActivityIndicator() {
        guard _activityIndicator == nil else { return }
        _activityIndicator = UIActivityIndicatorView()
        _activityIndicator?.hidesWhenStopped = true
        _activityIndicator?.isUserInteractionEnabled = false
        addSubview(_activityIndicator!)
        _activityIndicator?.makeConstraintsEdgesToSuperview()
    }

    public var hasActivityIndicator: Bool = false {
        willSet {
            isUserInteractionEnabled = !newValue
            createActivityIndicator()
            newValue ? _activityIndicator?.startAnimating() : _activityIndicator?.stopAnimating()
            _activityIndicator?.isHidden = !newValue
        }
    }
}
