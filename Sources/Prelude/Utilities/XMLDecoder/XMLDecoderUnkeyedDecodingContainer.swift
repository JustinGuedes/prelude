import Foundation

extension XMLDecoder {

    struct UDC: UnkeyedDecodingContainer {

        var elements: [XMLElement]
        var dateFormatters: [DateFormatter]
        
        var codingPath: [CodingKey] = []

        var count: Int? {
            return elements.count
        }

        var isAtEnd: Bool {
            return currentIndex >= elements.count
        }

        var currentIndex: Int = 0

        mutating func nextElement() -> XMLElement {
            let element = elements[currentIndex]
            currentIndex += 1
            return element
        }

        mutating func nextValue<T>(_ converter: (String) -> T?) throws -> T {
            let element = nextElement()
            guard let stringValue = element.value,
                  let value = converter(stringValue) else {
                throw DecodingError.dataCorruptedError(in: self,
                                                       debugDescription: "Malformed data.")
            }

            return value
        }

        mutating func decodeNil() throws -> Bool {
            throw DecodingError.valueNotFound(Any.self, DecodingError.Context(codingPath: codingPath,
                                                                              debugDescription: "decodeNil not supported."))
        }

        mutating func decode(_ type: Bool.Type) throws -> Bool {
            return try nextValue(Bool.init)
        }

        mutating func decode(_ type: String.Type) throws -> String {
            return try nextValue(XMLDecoder.identity)
        }

        mutating func decode(_ type: Double.Type) throws -> Double {
            return try nextValue(Double.init)
        }

        mutating func decode(_ type: Float.Type) throws -> Float {
            return try nextValue(Float.init)
        }

        mutating func decode(_ type: Int.Type) throws -> Int {
            return try nextValue(Int.init)
        }

        mutating func decode(_ type: Int8.Type) throws -> Int8 {
            return try nextValue(Int8.init)
        }

        mutating func decode(_ type: Int16.Type) throws -> Int16 {
            return try nextValue(Int16.init)
        }

        mutating func decode(_ type: Int32.Type) throws -> Int32 {
            return try nextValue(Int32.init)
        }

        mutating func decode(_ type: Int64.Type) throws -> Int64 {
            return try nextValue(Int64.init)
        }

        mutating func decode(_ type: UInt.Type) throws -> UInt {
            return try nextValue(UInt.init)
        }

        mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
            return try nextValue(UInt8.init)
        }

        mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
            return try nextValue(UInt16.init)
        }

        mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
            return try nextValue(UInt32.init)
        }

        mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
            return try nextValue(UInt64.init)
        }

        mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            let element = nextElement()
            let decoder = XMLDecoder(element: element, dateFormatters: dateFormatters)
            return try T(from: decoder)
        }

        mutating func nestedContainer<NestedKey: CodingKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
            let element = nextElement()
            return KeyedDecodingContainer(KDC(element: element, dateFormatters: dateFormatters))
        }

        mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
            let element = nextElement()
            return UDC(elements: element.children, dateFormatters: dateFormatters)
        }

        mutating func superDecoder() throws -> Decoder {
            throw DecodingError.typeMismatch(Decoder.self, DecodingError.Context(codingPath: codingPath,
                                                                                 debugDescription: "Does not support superDecoder"))
        }

    }

}
