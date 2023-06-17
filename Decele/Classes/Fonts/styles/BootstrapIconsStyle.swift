//
//  BootstrapIconsStyle.swift
//  Decele
//
//  Created by Mc Kevin on 25/06/23.
//

// MARK: - BootstrapIconsStyle
public enum BootstrapIconsStyle: String, FontStyle {
    case regular

    public static var name: String { "BootstrapIcons" }

    public static var prefix: String { "bi" }

    public static var tag: String { "v1.10.5" }

    public var fontFilePath: String {
        switch self {
        case .regular:
            return "bootstrap-icons.woff"
        }
    }
}
