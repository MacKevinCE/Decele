//
//  MaterialIconsStyle.swift
//  Decele
//
//  Created by Mc Kevin on 25/06/23.
//

// MARK: - MaterialIconsStyle
public enum MaterialIconsStyle: String, FontStyle {
    case outlined
    case filled
    case rounded
    case sharp
    
    public static var name: String { "MaterialIcons" }

    public static var prefix: String { "mi" }
    
    public static var tag: String { "v1.13.8" }

    public var fontFilePath: String {
        switch self {
        case .outlined:
            return "material-icons-outlined.woff"
        case .filled:
            return "material-icons.woff"
        case .rounded:
            return "material-icons-round.woff"
        case .sharp:
            return "material-icons-sharp.woff"
        }
    }
}
