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
    @discardableResult
    static func createEnum(name: String, prefix: String, codepoints: String, pathEnum: String) -> Bool {
        StylesCreate.createEnum(
            importDecele: false,
            name: name,
            prefix: prefix,
            allStyles: allCases.map(\.rawValue),
            codepoints: codepoints,
            pathEnum: pathEnum
        )
    }
}

func filePath(path: String) -> String {
    #file.replacingOccurrences(of: "/Decele/Classes/Fonts/tools/StylesCreate/main.swift", with: path)
}

BootstrapIconsStyle.createEnum(
    name: "BootstrapIcons",
    prefix: "bi",
    codepoints: filePath(path: "/FontLibraries/BootstrapIcons/font/bootstrap-icons.json"),
    pathEnum: filePath(path: "/Decele/Classes/Fonts/enums/BootstrapIcons.swift")
)

MaterialIconsStyle.createEnum(
    name: "MaterialIcons",
    prefix: "mi",
    codepoints: filePath(path: "/FontLibraries/MaterialIcons/_data/codepoints.json"),
    pathEnum: filePath(path: "/Decele/Classes/Fonts/enums/MaterialIcons.swift")
)

FontawesomeFreeStyle.createEnum(
    name: "FontawesomeFree",
    prefix: "faf",
    codepoints: filePath(path: "/FontLibraries/FontawesomeFree/metadata/icons.json"),
    pathEnum: filePath(path: "/Decele/Classes/Fonts/enums/FontawesomeFree.swift")
)

FontawesomeBrandsStyle.createEnum(
    name: "FontawesomeBrands",
    prefix: "fab",
    codepoints: filePath(path: "/FontLibraries/FontawesomeFree/metadata/icons.json"),
    pathEnum: filePath(path: "/Decele/Classes/Fonts/enums/FontawesomeBrands.swift")
)

exit(1)
