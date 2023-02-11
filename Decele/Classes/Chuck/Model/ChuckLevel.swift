//
//  DeceleType.swift
//  Decele
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public enum ChuckLevel: CaseIterable, Hashable, Equatable {
    public static var allCases: [ChuckLevel] = [.log, .service, .arc, .persistent]

    case custom(name: String, isEdit: Bool = true, showDeleteAll: Bool = true)
    case log
    case service
    case persistent
    case arc

    public var text: String {
        switch self {
        case let .custom(name, _, _): return name.uppercased()
        case .log: return "LOG"
        case .service: return "SERVICE"
        case .persistent: return "PERSISTENT"
        case .arc: return "ARC"
        }
    }

    public var isEditing: Bool {
        switch self {
        case let .custom(_, isEdit, _): return isEdit
        case .log: return true
        case .service: return true
        case .persistent: return false
        case .arc: return false
        }
    }

    public var showDeleteAll: Bool {
        switch self {
        case let .custom(_, _, showDeleteAll): return showDeleteAll
        case .log: return true
        case .service: return true
        case .persistent: return false
        case .arc: return false
        }
    }
}
