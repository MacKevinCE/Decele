//
//  FontawesomeBrandsStyle.swift
//  Decele
//
//  Created by Mc Kevin on 25/06/23.
//

// MARK: - FontawesomeBrandsStyle
public enum FontawesomeBrandsStyle: String, FontStyle {
    case brands

    public static var tag: String { "6.4.0" }

    public var fontFilePath: String {
        switch self {
        case .brands:
            return "Font Awesome 6 Brands-Regular-400.otf"
        }
    }
}
