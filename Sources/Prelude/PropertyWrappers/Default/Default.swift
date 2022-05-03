import Foundation

@propertyWrapper
public struct Default<Value: DefaultCodable> {
    public var wrappedValue: Value.ValueType

    public init() {
        wrappedValue = Value.defaultValue
    }
}

extension Default: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try container.decode(Value.ValueType.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }

}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type,
                   forKey key: Key) throws -> Default<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}
