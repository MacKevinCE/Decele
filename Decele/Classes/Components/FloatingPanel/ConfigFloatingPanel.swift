//
//  ConfigFloatingPanel.swift
//  SwiftyComponents
//
//  Created by Mc Kevin on 6/01/23.
//

import FloatingPanel

public struct ConfigFloatingPanel {
    public static var shared = ConfigFloatingPanel(fractionalInset: 0.5)

    public typealias Shadow = SurfaceAppearance.Shadow

    public var delegate: FloatingPanelControllerDelegate?
    public var position: FloatingPanelPosition
    public var initialState: FloatingPanelState
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring]
    public var cornerRadius: CGFloat
    public var backgroundColor: UIColor
    public var shadows: [Shadow]
    public var borderColor: UIColor
    public var borderWidth: CGFloat
    public var grabberHandleBarColor: UIColor
    public var grabberHandleIsHidden: Bool
    public var dismissalTapIsEnabled: Bool
    public var removeCompletion: (FloatingPanelController) -> Void
    public var changeState: (FloatingPanelController) -> Void

    public init(
        delegate: FloatingPanelControllerDelegate,
        cornerRadius: CGFloat = 0.0,
        backgroundColor: UIColor = .clear,
        shadows: [Shadow] = [Shadow()],
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0.0,
        grabberHandleBarColor: UIColor = UIColor(displayP3Red: 0.76, green: 0.77, blue: 0.76, alpha: 1.0),
        grabberHandleIsHidden: Bool = false,
        dismissalTapIsEnabled: Bool = true
    ) {
        self.delegate = delegate
        self.position = .bottom
        self.initialState = .tip
        self.anchors = [:]
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.shadows = shadows
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.grabberHandleBarColor = grabberHandleBarColor
        self.grabberHandleIsHidden = grabberHandleIsHidden
        self.dismissalTapIsEnabled = dismissalTapIsEnabled
        self.removeCompletion = { _ in }
        self.changeState = { _ in }
    }

    public init(
        position: FloatingPanelPosition = .bottom,
        initialState: FloatingPanelState = .tip,
        anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring],
        cornerRadius: CGFloat = 0.0,
        backgroundColor: UIColor = .clear,
        shadows: [Shadow] = [Shadow()],
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0.0,
        grabberHandleBarColor: UIColor = UIColor(displayP3Red: 0.76, green: 0.77, blue: 0.76, alpha: 1.0),
        grabberHandleIsHidden: Bool = false,
        dismissalTapIsEnabled: Bool = true,
        removeCompletion: @escaping (FloatingPanelController) -> Void = { _ in },
        changeState: @escaping (FloatingPanelController) -> Void = { _ in }
    ) {
        self.delegate = nil
        self.position = position
        self.initialState = initialState
        self.anchors = anchors
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.shadows = shadows
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.grabberHandleBarColor = grabberHandleBarColor
        self.grabberHandleIsHidden = grabberHandleIsHidden
        self.dismissalTapIsEnabled = dismissalTapIsEnabled
        self.removeCompletion = removeCompletion
        self.changeState = changeState
    }

    public init(
        position: FloatingPanelPosition = .bottom,
        initialState: FloatingPanelState = .tip,
        state: [StateFloatingPanel] = StateFloatingPanel.allCases,
        absoluteInset: CGFloat,
        incrementalHalf: CGFloat = 0,
        referenceGuide: FloatingPanelLayoutReferenceGuide = .superview,
        cornerRadius: CGFloat = 0.0,
        backgroundColor: UIColor = .clear,
        shadows: [Shadow] = [Shadow()],
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0.0,
        grabberHandleBarColor: UIColor = UIColor(displayP3Red: 0.76, green: 0.77, blue: 0.76, alpha: 1.0),
        grabberHandleIsHidden: Bool = false,
        dismissalTapIsEnabled: Bool = true,
        removeCompletion: @escaping (FloatingPanelController) -> Void = { _ in },
        changeState: @escaping (FloatingPanelController) -> Void = { _ in }
    ) {
        var newState = state
        newState.append(StateFloatingPanel(initialState))
        self.init(anchors: .init(state: newState, absoluteInset: absoluteInset, incrementalHalf: incrementalHalf, edge: .init(position)), cornerRadius: cornerRadius, backgroundColor: backgroundColor, shadows: shadows, borderColor: borderColor, borderWidth: borderWidth, grabberHandleBarColor: grabberHandleBarColor, grabberHandleIsHidden: grabberHandleIsHidden, dismissalTapIsEnabled: dismissalTapIsEnabled, removeCompletion: removeCompletion, changeState: changeState)
    }

    public init(
        position: FloatingPanelPosition = .bottom,
        initialState: FloatingPanelState = .tip,
        state: [StateFloatingPanel] = StateFloatingPanel.allCases,
        fractionalInset: CGFloat,
        incrementalHalf: CGFloat = 0,
        referenceGuide: FloatingPanelLayoutReferenceGuide = .superview,
        cornerRadius: CGFloat = 0.0,
        backgroundColor: UIColor = .clear,
        shadows: [Shadow] = [Shadow()],
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0.0,
        grabberHandleBarColor: UIColor = UIColor(displayP3Red: 0.76, green: 0.77, blue: 0.76, alpha: 1.0),
        grabberHandleIsHidden: Bool = false,
        dismissalTapIsEnabled: Bool = true,
        removeCompletion: @escaping (FloatingPanelController) -> Void = { _ in },
        changeState: @escaping (FloatingPanelController) -> Void = { _ in }
    ) {
        var newState = state
        newState.append(StateFloatingPanel(initialState))
        self.init(anchors: .init(state: newState, fractionalInsetTip: fractionalInset, incrementalHalf: incrementalHalf, edge: .init(position)), cornerRadius: cornerRadius, backgroundColor: backgroundColor, shadows: shadows, borderColor: borderColor, borderWidth: borderWidth, grabberHandleBarColor: grabberHandleBarColor, grabberHandleIsHidden: grabberHandleIsHidden, dismissalTapIsEnabled: dismissalTapIsEnabled, removeCompletion: removeCompletion, changeState: changeState)
    }
}
