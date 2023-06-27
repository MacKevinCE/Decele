//
//  FontLoad.swift
//  Decele
//
//  Created by Mc Kevin on 24/06/23.
//

import CoreText
import Foundation

// MARK: - FontStyle
extension FontStyle {
    private func fontURL() -> URL? {
        let withExtension = fontFilePath.pathExtension
        let forResource = fontFilePath.deletingPathExtension

        // If this project principal
        if let fontURL = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
            return fontURL
        }

        if let fontURL = Bundle.main.url(forResource: forResource, withExtension: withExtension, subdirectory: "\(Self.name).bundle") {
            return fontURL
        }

        #if SWIFT_PACKAGE
            if let fontURL = Bundle.module.url(forResource: fontName, withExtension: "otf") {
                return fontURL
            }

            if let fontURL = Bundle.module.url(forResource: fontName, withExtension: "otf", subdirectory: "\(Self.name).bundle") {
                return fontURL
            }
        #endif

        // If this framework is added using CocoaPods, resources is placed under a subdirectory
        let bundle = Bundle(for: FontSetting.self)

        if let fontURL = bundle.url(forResource: forResource, withExtension: withExtension) {
            return fontURL
        }

        if let fontURL = bundle.url(forResource: forResource, withExtension: withExtension, subdirectory: "\(Self.name).bundle") {
            return fontURL
        }

        return URL(fileURLWithPath: fontFilePath)
    }

    func loadFont() {
        let getFontNames = getFontNames()
        if UIFont.fontNames(forFamilyName: getFontNames.familyName).contains(getFontNames.postScriptName) {
            return
        }

        guard
            let fontURL = fontURL() as CFURL?
        else { return }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterFontsForURL(fontURL, .process, &error) {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return }
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }

    func getFontNames() -> (fullName: String, postScriptName: String, familyName: String) {
        if let fontURL = fontURL(), let fontData = try? Data(contentsOf: fontURL) as CFData,
           let provider = CGDataProvider(data: fontData),
           let cgFont = CGFont(provider),
           let fullName = cgFont.fullName as? String,
           let postScriptName = cgFont.postScriptName as? String
        {
            let font = CTFontCreateWithGraphicsFont(cgFont, 0, nil, nil)
            let familyName = CTFontCopyFamilyName(font) as String // Obtiene el nombre de familia de fuente

            return (fullName: fullName, postScriptName: postScriptName, familyName: familyName)
        } else {
            return (fullName: "", postScriptName: "", familyName: "")
        }
    }
}
