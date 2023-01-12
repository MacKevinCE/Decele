//
//  Config.swift
//  Persistent
//
//  Created by Mc Kevin on 31/12/22.
//

import Foundation

public class ConfigPersistent {
    public static var shared = ConfigPersistent()

    public var configUserDefaults: EncryptMethod
    public var configKeychain: EncryptMethod

    init(configUserDefaults: EncryptMethod = EncryptMethod(), configKeychain: EncryptMethod = EncryptMethod()) {
        self.configUserDefaults = configUserDefaults
        self.configKeychain = configKeychain
    }
}

public struct EncryptMethod {
    public typealias Typecrypt = (Data, String) -> Data?

    public var encrypt: Typecrypt
    public var decrypt: Typecrypt

    public init(
        encrypt: @escaping Typecrypt = { data, _ in data },
        decrypt: @escaping Typecrypt = { data, _ in data })
    {
        self.encrypt = encrypt
        self.decrypt = decrypt
    }
}
