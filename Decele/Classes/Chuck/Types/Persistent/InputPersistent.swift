//
//  InputPersistent.swift
//  Decele
//
//  Created by Mc Kevin on 9/11/22.
//

import Foundation

struct InputPersistent: InputProtocol {
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let namespace: String
    let key: String
    let value: Any?

    init(
        _ namespace: String,
        _ key: String,
        _ value: Any?,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.file = file
        self.function = function
        self.line = line
        type = .persistent
        self.namespace = namespace
        self.key = key
        self.value = value
    }

    func output() -> OutputPersistent {
        OutputPersistent(self)
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(key):"
            .applying(font: .semibold16, color: .systemBlue)
            .printSpacer()
            .addTextApplying(text: getValueOneLine())
        return .attributed(attributed, numberOfLines: 2)
    }

    func getTabResume() -> NSMutableAttributedString {
        var attributeText = NSMutableAttributedString()

        if let namespace = namespace.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("NAMESPACE")
                .printEnter()
                .printJSONForChuck(namespace)
                .printEnter()
        }

        if let key = key.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("KEY")
                .printEnter()
                .printJSONForChuck(key)
                .printEnter()
        }

        if let type = getType().nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("TYPE")
                .printEnter()
                .printJSONForChuck(type)
                .printEnter()
        }

        if let value = getValue().nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("VALUE")
                .printEnter()
                .printJSONForChuck(value)
                .printEnter()
        }

        return attributeText
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [String: String] = [:]
        pares["ID"] = id.uuidString
        pares["Namespace"] = namespace
        pares["Key"] = key
        pares["Value"] = getValue()
        pares["Type As"] = getType()
        pares["JSON value"] = Self.jsonClass(of: value)
        pares["File"] = Chuck.getPath(file)
        pares["Function"] = function
        pares["Line"] = String(line)
        pares["Time"] = time.string(withFormat: .iso8601)
        return pares.toAttributedString()
    }

    func getType() -> String {
        [
            type(with: [Any].self),
            type(with: [String].self),
            type(with: [Int].self),
            type(with: Bool.self),
            type(with: Character.self),
            type(with: [String: Any].self),
            type(with: Date.self),
            type(with: Data.self),
            type(with: Double.self),
            type(with: DispatchTime.self),
            type(with: Float.self),
            type(with: Int.self),
            type(with: IndexPath.self),
            type(with: Locale.self),
            type(with: Notification.self),
            type(with: String.self),
            type(with: Timer.self),
            type(with: URL.self),
            type(with: URLRequest.self),
            type(with: URLSession.self),
        ].compactMap { $0 }.joined(separator: ", ")
    }

    func type<T>(with _: T.Type) -> String? {
        if let value = value, value is T {
            return String(describing: T.self)
        } else {
            return nil
        }
    }

    func getValueOneLine() -> String {
        let value = getValue()
        return value.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }.joined(separator: "")
    }

    func getValue() -> String {
        guard let value = value else { return "nil" }
        if let value = value as? CustomStringConvertible {
            return value.description
        } else if let value = value as? CustomDebugStringConvertible {
            return value.debugDescription
        }
        return String(describing: value)
    }

    static func jsonClass(of value: Any?) -> String {
        (value as? Encodable)?.toPrettyPrintedJSONString() ?? .empty
    }
}
