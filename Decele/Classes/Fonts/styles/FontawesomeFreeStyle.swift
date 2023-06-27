//
//  FontawesomeFreeStyle.swift
//  Decele
//
//  Created by Mc Kevin on 25/06/23.
//

// MARK: - FontawesomeFreeStyle
public enum FontawesomeFreeStyle: String, FontStyle {
    case solid
    case regular
    
    public static var tag: String { "6.4.0" }

    public var fontFilePath: String {
        switch self {
        case .solid:
            return "Font Awesome 6 Free-Solid-900.otf"
        case .regular:
            return "Font Awesome 6 Free-Regular-400.otf"
        }
    }
}
