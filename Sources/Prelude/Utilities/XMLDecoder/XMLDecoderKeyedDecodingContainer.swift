import Foundation

extension XMLDecoder {

    struct KDC<Key: CodingKey>: KeyedDecodingContainerProtocol {

        var element: XMLElement
        var dateFormatters: [DateFormatter]

        var codingPath: [CodingKey] = []
        var allKeys: [Key] = []

        func child(for key: Key) throws -> XMLElement {
            guard let child = element.child(for: key.stringValue) else {
                throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: codingPath,
                                                                           debugDescription: "Could not find child element \(key.stringValue) from \(element.name)"))
            }

            return child
        }

        func children(for key: Key) -> [XMLElement] {
            return element.children(for: key.stringValue)
        }

        func valueFromChild<T>(_ converter: (String) -> T?, for key: Key) throws -> T {
            let stringValue = try element.attribute(for: key.stringValue) ?? (try self.child(for: key)).value
            guard let value = stringValue,
                let convertedValue = converter(value) else {
                throw DecodingError.dataCorruptedError(forKey: key,
                                                       in: self,
                                                       debugDescription: "Malformed data.")
            }

            return convertedValue
        }

        func contains(_ key: Key) -> Bool {
            let child = try? self.child(for: key)
            return child != nil || element.attribute(for: key.stringValue) != nil
        }

        func decodeNil(forKey key: Key) throws -> Bool {
            let child = try? self.child(for: key)
            return (child?.value == nil && child?.children.count == 0 && child?.attributes.count == 0)
                || child?.attributes["nil"] != nil
        }

        func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
            return try valueFromChild(Bool.init, for: key)
        }

        func decode(_ type: String.Type, forKey key: Key) throws -> String {
            return try valueFromChild(XMLDecoder.identity, for: key)
        }

        func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
            return try valueFromChild(Double.init, for: key)
        }

        func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
            return try valueFromChild(Float.init, for: key)
        }

        func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
            return try valueFromChild(Int.init, for: key)
        }

        func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
            return try valueFromChild(Int8.init, for: key)
        }

        func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
            return try valueFromChild(Int16.init, for: key)
        }

        func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
            return try valueFromChild(Int32.init, for: key)
        }

        func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
            return try valueFromChild(Int64.init, for: key)
        }

        func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
            return try valueFromChild(UInt.init, for: key)
        }

        func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
            return try valueFromChild(UInt8.init, for: key)
        }

        func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
            return try valueFromChild(UInt16.init, for: key)
        }

        func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
            return try valueFromChild(UInt32.init, for: key)
        }

        func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
            return try valueFromChild(UInt64.init, for: key)
        }

        func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
            if type == URL.self {
                guard let url = try valueFromChild(URL.init(string:), for: key) as? T else {
                    throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Could not parse url.")
                }

                return url
            } else if type == Date.self {
                let element = try self.child(for: key)
                guard let dateString = element.value else {
                    throw DecodingError.valueNotFound(Date.self, DecodingError.Context(codingPath: codingPath,
                                                                                       debugDescription: "Could not find date value."))
                }

                for formatter in dateFormatters {
                    if let date = formatter.date(from: dateString) as? T {
                        return date
                    }
                }

                throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Could not parse date.")
            }

            // Check if its an array of elements
            let elements = children(for: key)
            if elements.count > 1 {
                let array = XMLElement(name: key.stringValue, children: elements)
                let decoder = XMLDecoder(element: array, dateFormatters: dateFormatters)
                return try T(from: decoder)
            } else {
                let element = (try? child(for: key)) ?? self.element
                let decoder = XMLDecoder(element: element, dateFormatters: dateFormatters)
                return try T(from: decoder)
            }
        }

        func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
            let element = try self.child(for: key)
            return KeyedDecodingContainer(KDC<NestedKey>(element: element, dateFormatters: dateFormatters))
        }

        func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
            let elements = children(for: key)
            return UDC(elements: elements, dateFormatters: dateFormatters)
        }

        func superDecoder() throws -> Decoder {
            throw DecodingError.typeMismatch(Decoder.self, DecodingError.Context(codingPath: codingPath,
                                                                                 debugDescription: "Does not support superDecoder"))
        }

        func superDecoder(forKey key: Key) throws -> Decoder {
            throw DecodingError.typeMismatch(Decoder.self, DecodingError.Context(codingPath: codingPath,
                                                                                 debugDescription: "Does not support superDecoder"))
        }

    }

}
