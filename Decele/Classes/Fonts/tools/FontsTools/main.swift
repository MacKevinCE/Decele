//
//  main.swift
//  FontsTools
//
//  Created by Mc Kevin on 25/06/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

// MARK: - Argument
enum Argument: String, CaseIterable {
    case importDecele
    case nameEnum
    case prefix
    case allStyles
    case inputPath
    case outputPath

    var value: String? {
        let arguments = CommandLine.arguments
        guard
            let index = arguments.firstIndex(of: self.rawValue),
            arguments.count > index + 1,
            arguments[index] == self.rawValue
        else { return nil }

        return arguments[index + 1]
    }

    var help: String {
        """
        Se requiere parámetro de entrada: \(rawValue)
        """
    }
}

if
    let nameEnum = Argument.nameEnum.value,
    let allStyles = Argument.allStyles.value?.split(separator: ",").map({ String($0).trimmingCharacters(in: .whitespacesAndNewlines) }),
    let inputPath = Argument.inputPath.value,
    let outputPath = Argument.outputPath.value
{
    let importDecele = (Argument.importDecele.value ?? "true").bool ?? false

    let prefix = Argument.prefix.value ?? ""
    if createEnum(importDecele: importDecele, name: nameEnum, prefix: prefix, allStyles: allStyles, codepoints: inputPath, pathEnum: outputPath) {
        print("Se creó correctamente el archivo")
    } else {
        print("Error en los parámetros de entrada")
    }
} else {
    print("Se requieren dos parámetros de entrada: \(Argument.allCases.map(\.rawValue).joined(separator: ", "))")
}

exit(0)
