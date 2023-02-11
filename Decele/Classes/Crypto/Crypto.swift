//
//  Crypto.swift
//  Decele
//
//  Created by Mac Kevin Cabanillas Encarnacion on 7/22/21.
//

import CryptoKit
import Foundation
import SwifterSwift

public enum Crypto {
    public static func getSymmetricKey(pass: String?) -> SymmetricKey? {
        guard let pass = pass, let data = pass.data(using: .utf8) else { return nil }
        return SymmetricKey(data: SHA256.hash(data: data))
    }

    public static func signatureHMAC<T: Encodable>(_ value: T, pass: String?) -> String? {
        guard let key = getSymmetricKey(pass: pass) else { return nil }
        guard let data = value.encode else { return nil }
        return Data(HMAC<SHA512>.authenticationCode(for: data, using: key)).base64EncodedString().urlEncoded
    }

    public static func isValidSignatureHMAC<T: Encodable>(_ signature: String, value: T, pass: String?) -> Bool {
        guard let otherSignature = signatureHMAC(value, pass: pass) else { return false }
        return signature == otherSignature
    }

    public static func createSealedBox(data: Data, pass: String?) -> Data? {
        guard let key = getSymmetricKey(pass: pass) else { return nil }
        guard let sealedBox = try? AES.GCM.seal(data, using: key, nonce: AES.GCM.Nonce()) else { return nil }
        return sealedBox.combined
    }

    public static func createSealedBox(data: Data, pass: String?) -> String? {
        return createSealedBox(data: data, pass: pass)?.base64EncodedString().urlEncoded
    }

    public static func createSealedBox<T: Encodable>(_ value: T, pass: String?) -> Data? {
        guard let data = value.encode else { return nil }
        return createSealedBox(data: data, pass: pass)
    }

    public static func createSealedBox<T: Encodable>(_ value: T, pass: String?) -> String? {
        guard let data = value.encode else { return nil }
        return createSealedBox(data: data, pass: pass)
    }

    public static func openSealedBox(_ sealedBox: Data?, pass: String?) -> Data? {
        guard let data = sealedBox else { return nil }
        guard let key = getSymmetricKey(pass: pass) else { return nil }
        guard let sealedBox = try? AES.GCM.SealedBox(combined: data) else { return nil }
        return try? AES.GCM.open(sealedBox, using: key)
    }

    public static func openSealedBox(_ sealedBoxString: String?, pass: String?) -> Data? {
        guard let string = sealedBoxString else { return nil }
        guard let sealedBox = Data(base64Encoded: string.urlDecoded) else { return nil }
        return openSealedBox(sealedBox, pass: pass)
    }

    public static func openSealedBox<T: Decodable>(_ sealedBox: Data?, pass: String?) -> T? {
        guard let decryptedData = openSealedBox(sealedBox, pass: pass) else { return nil }
        return T(from: decryptedData)
    }

    public static func openSealedBox<T: Decodable>(_ sealedBox: String?, pass: String?) -> T? {
        guard let decryptedData = openSealedBox(sealedBox, pass: pass) else { return nil }
        return T(from: decryptedData)
    }
}
