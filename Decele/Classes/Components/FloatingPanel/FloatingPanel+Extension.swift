//
//  FloatingPanel+Extension.swift
//  InglesYa
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/17/21.
//

import FloatingPanel

public enum StateFloatingPanel: String, CaseIterable {
    case full, half, tip, hidden

    init(_ state: FloatingPanelState) {
        self.init(rawValue: state.rawValue)!
    }
}

extension Dictionary where Key == FloatingPanelState, Value == FloatingPanelLayoutAnchoring {
    init(state: [StateFloatingPanel] = StateFloatingPanel.allCases, absoluteInset: CGFloat, incrementalHalf: CGFloat = 0, edge: FloatingPanelReferenceEdge = .bottom, referenceGuide: FloatingPanelLayoutReferenceGuide = .superview) {
        var dictionary: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [:]
        if state.contains(.full) {
            dictionary[.full] = FloatingPanelLayoutAnchor(fractionalInset: 1, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.half) {
            let absoluteInsetFinal = Swift.max(0, Swift.min(absoluteInset + incrementalHalf, UIScreen.main.bounds.height))
            dictionary[.half] = FloatingPanelLayoutAnchor(absoluteInset: absoluteInsetFinal, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.tip) {
            let absoluteInsetFinal = Swift.max(0, Swift.min(absoluteInset, UIScreen.main.bounds.height))
            dictionary[.tip] = FloatingPanelLayoutAnchor(absoluteInset: absoluteInsetFinal, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.hidden) {
            dictionary[.hidden] = FloatingPanelLayoutAnchor(fractionalInset: 0, edge: edge, referenceGuide: referenceGuide)
        }
        self = dictionary
    }

    init(state: [StateFloatingPanel] = StateFloatingPanel.allCases, fractionalInsetTip: CGFloat, incrementalHalf: CGFloat = 0, edge: FloatingPanelReferenceEdge = .bottom, referenceGuide: FloatingPanelLayoutReferenceGuide = .superview) {
        var dictionary: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [:]
        if state.contains(.full) {
            dictionary[.full] = FloatingPanelLayoutAnchor(fractionalInset: 1, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.half) {
            let fractionalInsetFinal = Swift.max(0, Swift.min(fractionalInsetTip + incrementalHalf, 1))
            dictionary[.half] = FloatingPanelLayoutAnchor(fractionalInset: fractionalInsetFinal, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.tip) {
            let fractionalInsetFinal = Swift.max(0, Swift.min(fractionalInsetTip, 1))
            dictionary[.tip] = FloatingPanelLayoutAnchor(fractionalInset: fractionalInsetFinal, edge: edge, referenceGuide: referenceGuide)
        }
        if state.contains(.hidden) {
            dictionary[.hidden] = FloatingPanelLayoutAnchor(fractionalInset: 0, edge: edge, referenceGuide: referenceGuide)
        }
        self = dictionary
    }
}

extension FloatingPanelReferenceEdge {
    init(_ position: FloatingPanelPosition) {
        self.init(rawValue: position.rawValue)!
    }
}
