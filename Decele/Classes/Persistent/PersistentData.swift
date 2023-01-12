//
//  PersistentData.swift
//  Persistent
//
//  Created by Mc Kevin on 31/12/22.
//

import Foundation

public extension Persistent {
    struct PersistentData<V: Codable> {
        private var key: TypeKey
        private var defaultValue: V

        public init(_ key: TypeKey, defaultValue: V) {
            self.key = key
            self.defaultValue = defaultValue
        }

        public init(_ key: TypeKey) where V: RangeReplaceableCollection {
            self.key = key
            self.defaultValue = V()
        }

        public init(_ key: TypeKey) where V: SetAlgebra {
            self.key = key
            self.defaultValue = V()
        }

        public init(_ key: TypeKey) where V: BinaryInteger {
            self.key = key
            self.defaultValue = V()
        }

        public init(_ key: TypeKey) where V == String {
            self.key = key
            self.defaultValue = V()
        }

        public init(_ key: TypeKey) where V == Bool {
            self.key = key
            self.defaultValue = V()
        }

        public init<Key: Hashable, Value>(_ key: TypeKey) where V == [Key: Value] {
            self.key = key
            self.defaultValue = V()
        }

        public var value: V {
            set {
                guard let data = newValue.encode() else {
                    key.removeObject()
                    return
                }
                key.setData(data)
            }
            get {
                guard let data = key.getData(), let value = V(from: data) else {
                    return defaultValue
                }
                return value
            }
        }

        public func removeObject() {
            key.removeObject()
        }
    }
}

extension Persistent.PersistentData: IteratorProtocol where V: IteratorProtocol {
    public mutating func next() -> V.Element? {
        return value.next()
    }
}

extension Persistent.PersistentData: Equatable where V: Equatable {
    public static func == (lhs: Persistent.PersistentData<V>, rhs: Persistent.PersistentData<V>) -> Bool {
        return lhs.value == rhs.value
    }

    public static func == (lhs: V, rhs: Persistent.PersistentData<V>) -> Bool {
        return lhs == rhs.value
    }

    public static func == (lhs: Persistent.PersistentData<V>, rhs: V) -> Bool {
        return lhs.value == rhs
    }

    public static func != (lhs: Persistent.PersistentData<V>, rhs: Persistent.PersistentData<V>) -> Bool {
        return lhs.value != rhs.value
    }

    public static func != (lhs: V, rhs: Persistent.PersistentData<V>) -> Bool {
        return lhs != rhs.value
    }

    public static func != (lhs: Persistent.PersistentData<V>, rhs: V) -> Bool {
        return lhs.value != rhs
    }
}

extension Persistent.PersistentData: Hashable where V: Hashable {
    public func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
}

extension Persistent.PersistentData: CustomStringConvertible where V: CustomStringConvertible {
    public var description: String {
        return value.description
    }
}

extension Persistent.PersistentData: CustomDebugStringConvertible where V: CustomDebugStringConvertible {
    public var debugDescription: String {
        return value.debugDescription
    }
}
