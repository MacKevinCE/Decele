//
//  DeceleOptional.swift
//  Decele
//
//  Created by Mc Kevin on 31/12/22.
//

import Foundation

public extension Persistent {
    struct PersistentOptional<V: Codable> {
        private var key: TypeKey

        public init(_ key: TypeKey) {
            self.key = key
        }

        public var value: V? {
            set {
                guard let data = newValue.encode else {
                    key.removeObject()
                    return
                }
                key.setData(data)
            }
            get {
                guard let data = key.getData(), let value = V(from: data) else {
                    return nil
                }
                return value
            }
        }

        public func removeObject() {
            key.removeObject()
        }
    }
}

// MARK: - Persistent.PersistentOptional + IteratorProtocol
extension Persistent.PersistentOptional: IteratorProtocol where V: IteratorProtocol {
    public mutating func next() -> V.Element? {
        value?.next()
    }
}

// MARK: - Persistent.PersistentOptional + Equatable
extension Persistent.PersistentOptional: Equatable where V: Equatable {
    public static func == (lhs: Persistent.PersistentOptional<V>, rhs: Persistent.PersistentOptional<V>) -> Bool {
        lhs.value == rhs.value
    }

    public static func == (lhs: V, rhs: Persistent.PersistentOptional<V>) -> Bool {
        lhs == rhs.value
    }

    public static func == (lhs: Persistent.PersistentOptional<V>, rhs: V) -> Bool {
        lhs.value == rhs
    }

    public static func != (lhs: Persistent.PersistentOptional<V>, rhs: Persistent.PersistentOptional<V>) -> Bool {
        lhs.value != rhs.value
    }

    public static func != (lhs: V, rhs: Persistent.PersistentOptional<V>) -> Bool {
        lhs != rhs.value
    }

    public static func != (lhs: Persistent.PersistentOptional<V>, rhs: V) -> Bool {
        lhs.value != rhs
    }
}

// MARK: - Persistent.PersistentOptional + Hashable
extension Persistent.PersistentOptional: Hashable where V: Hashable {
    public func hash(into hasher: inout Hasher) {
        value?.hash(into: &hasher)
    }
}

// MARK: - Persistent.PersistentOptional + CustomStringConvertible
extension Persistent.PersistentOptional: CustomStringConvertible where V: CustomStringConvertible {
    public var description: String {
        value?.description ?? "nil"
    }
}

// MARK: - Persistent.PersistentOptional + CustomDebugStringConvertible
extension Persistent.PersistentOptional: CustomDebugStringConvertible where V: CustomDebugStringConvertible {
    public var debugDescription: String {
        value?.debugDescription ?? "nil"
    }
}
