//
//  PersistentOptional.swift
//  Persistent
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
                guard let data = newValue.encode() else {
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

extension Persistent.PersistentOptional: IteratorProtocol where V: IteratorProtocol {
    public mutating func next() -> V.Element? {
        return value?.next()
    }
}

extension Persistent.PersistentOptional: Equatable where V: Equatable {
    public static func == (lhs: Persistent.PersistentOptional<V>, rhs: Persistent.PersistentOptional<V>) -> Bool {
        return lhs.value == rhs.value
    }

    public static func == (lhs: V, rhs: Persistent.PersistentOptional<V>) -> Bool {
        return lhs == rhs.value
    }

    public static func == (lhs: Persistent.PersistentOptional<V>, rhs: V) -> Bool {
        return lhs.value == rhs
    }

    public static func != (lhs: Persistent.PersistentOptional<V>, rhs: Persistent.PersistentOptional<V>) -> Bool {
        return lhs.value != rhs.value
    }

    public static func != (lhs: V, rhs: Persistent.PersistentOptional<V>) -> Bool {
        return lhs != rhs.value
    }

    public static func != (lhs: Persistent.PersistentOptional<V>, rhs: V) -> Bool {
        return lhs.value != rhs
    }
}

extension Persistent.PersistentOptional: Hashable where V: Hashable {
    public func hash(into hasher: inout Hasher) {
        value?.hash(into: &hasher)
    }
}

extension Persistent.PersistentOptional: CustomStringConvertible where V: CustomStringConvertible {
    public var description: String {
        return value?.description ?? "nil"
    }
}

extension Persistent.PersistentOptional: CustomDebugStringConvertible where V: CustomDebugStringConvertible {
    public var debugDescription: String {
        return value?.debugDescription ?? "nil"
    }
}
