//
//  main.swift
//  FontsTools
//
//  Created by Mc Kevin on 25/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//
import Foundation

// MARK: - FontStyle
extension FontStyle {
    static func addPrefix(name: String) -> String {
        StylesTools.addPrefix(prefix, name)
    }

    static func hasStylesAllowed(value: FontDicValue) -> Bool {
        StylesTools.hasStylesAllowed(allStyles: allCases.map(\.rawValue), value: value)
    }

    static func onlyFiltersAllowed(styles: [String]) -> [String] {
        StylesTools.onlyFiltersAllowed(allStyles: allCases.map(\.rawValue), styles: styles)
    }

    @discardableResult
    static func createEnum(codepoints: String, pathEnum: String) -> Bool {
        StylesTools.createEnum(
            name: name,
            prefix: prefix,
            allStyles: allCases.map(\.rawValue),
            codepoints: codepoints,
            pathEnum: pathEnum
        )
    }
}

func filePath(path: String) -> String {
    #file.replacingOccurrences(of: "/Decele/Classes/Fonts/tools/main.swift", with: path)
}

BootstrapIconsStyle.createEnum(
    codepoints: filePath(path: "/FontLibraries/BootstrapIcons/font/bootstrap-icons.json"),
    pathEnum: "\(filePath(path: "/Decele/Classes/Fonts/enums/"))\(BootstrapIconsStyle.name).swift"
)

MaterialIconsStyle.createEnum(
    codepoints: filePath(path: "/FontLibraries/MaterialIcons/_data/codepoints.json"),
    pathEnum: "\(filePath(path: "/Decele/Classes/Fonts/enums/"))\(MaterialIconsStyle.name).swift"
)

FontawesomeFreeStyle.createEnum(
    codepoints: filePath(path: "/FontLibraries/FontawesomeFree/metadata/icons.json"),
    pathEnum: "\(filePath(path: "/Decele/Classes/Fonts/enums/"))\(FontawesomeFreeStyle.name).swift"
)

FontawesomeBrandsStyle.createEnum(
    codepoints: filePath(path: "/FontLibraries/FontawesomeFree/metadata/icons.json"),
    pathEnum: "\(filePath(path: "/Decele/Classes/Fonts/enums/"))\(FontawesomeBrandsStyle.name).swift"
)

exit(1)
