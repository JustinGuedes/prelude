import Foundation

public struct XMLDecoder: Decoder {

    var element: XMLElement
    var dateFormatters: [DateFormatter]

    public var codingPath: [CodingKey] = []
    public var userInfo: [CodingUserInfoKey : Any] = [:]

    public init(element: XMLElement, dateFormatters: [DateFormatter]) {
        self.element = element
        self.dateFormatters = dateFormatters
    }

    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(KDC(element: element, dateFormatters: dateFormatters))
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return UDC(elements: element.children, dateFormatters: dateFormatters)
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return SVDC(element: element, dateFormatters: dateFormatters)
    }

    static func identity<T>(_ value: T) -> T? {
        return value
    }

}
