//
//  InputLog.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

// MARK: - InputLog
struct InputLog: InputProtocol {
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let level: LogLevel
    let colorText: UIColor
    let items: [String]
    let separator: String
    let terminator: String

    init(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        _ level: LogLevel,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.file = file
        self.function = function
        self.line = line
        type = .log
        self.level = level
        colorText = getColor(level)
        self.items = items.map { "\($0)" }
        self.separator = separator
        self.terminator = terminator
    }

    func output() -> OutputLog {
        return OutputLog(self)
    }

    func getTitle() -> String {
        return "\(items.joined(separator: separator.visible()))\(terminator.visibleUltra())"
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(level.text):"
            .applying(font: .semibold16, color: colorText)
            .printSpacer()
            .addTextApplying(text: getTitle())
            .printEnter().printTab().printTab().printSpacer()
            .addTextApplying(text: time.string(withFormat: .timeMedium), font: .regular12, color: .gray)
        return .attributed(attributed)
    }

    func getTabResume() -> NSMutableAttributedString {
        var attributeText = NSMutableAttributedString()

        if let text = getText().nullable {
            attributeText = attributeText
                .printTitleChuck("TEXT")
                .printEnter()
                .printJSONForChuck(text)
                .printEnter()
        }

        if let file = Chuck.getPath(file).nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("FILE")
                .printEnter()
                .printJSONForChuck(file)
                .printEnter()
        }

        if let line = String(line).nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("LINE")
                .printEnter()
                .printJSONForChuck(line)
                .printEnter()
        }

        return attributeText
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [String: String] = [:]
        pares["ID"] = id.uuidString
        pares["Text"] = getText()
        pares["Items"] = getItems()
        pares["Separator"] = separator.visibleUltra()
        pares["Terminator"] = terminator.visibleUltra()
        pares["File"] = Chuck.getPath(file)
        pares["Function"] = function
        pares["Line"] = String(line)
        pares["Time"] = time.string(withFormat: .iso8601)
        return pares.toAttributedString()
    }

    func getText() -> String {
        return items.joined(separator: separator) + terminator
    }

    func getItems() -> String {
        return "[" + items.map { $0.visibleUltra() }.joined(separator: ", ") + "]"
    }
}

func getColor(_ type: LogLevel) -> UIColor {
    switch type {
    case .print: return .darkText
    case .debug: return .systemGreen
    case .info: return .systemBlue
    case .warning: return .systemOrange
    case .error: return .systemRed
    }
}

// MARK: - LogLevel
enum LogLevel: CaseIterable {
    case print
    case debug
    case info
    case warning
    case error

    var text: String {
        switch self {
        case .print: return "Print"
        case .debug: return "Debug"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        }
    }
}
