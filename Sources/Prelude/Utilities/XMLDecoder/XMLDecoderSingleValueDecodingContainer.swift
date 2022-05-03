import Foundation

extension XMLDecoder {

    struct SVDC: SingleValueDecodingContainer {

        var element: XMLElement
        var dateFormatters: [DateFormatter]

        var codingPath: [CodingKey] = []

        func value<T>(_ converter: (String) -> T?) throws -> T {
            guard let stringValue = element.value,
                  let value = converter(stringValue) else {
                throw DecodingError.dataCorruptedError(in: self,
                                                       debugDescription: "Malformed data.")

            }

            return value
        }

        func decodeNil() -> Bool {
            return element.value != nil
        }

        func decode(_ type: Bool.Type) throws -> Bool {
            return try value(Bool.init)
        }

        func decode(_ type: String.Type) throws -> String {
            return try value(XMLDecoder.identity)
        }

        func decode(_ type: Double.Type) throws -> Double {
            return try value(Double.init)
        }

        func decode(_ type: Float.Type) throws -> Float {
            return try value(Float.init)
        }

        func decode(_ type: Int.Type) throws -> Int {
            return try value(Int.init)
        }

        func decode(_ type: Int8.Type) throws -> Int8 {
            return try value(Int8.init)
        }

        func decode(_ type: Int16.Type) throws -> Int16 {
            return try value(Int16.init)
        }

        func decode(_ type: Int32.Type) throws -> Int32 {
            return try value(Int32.init)
        }

        func decode(_ type: Int64.Type) throws -> Int64 {
            return try value(Int64.init)
        }

        func decode(_ type: UInt.Type) throws -> UInt {
            return try value(UInt.init)
        }

        func decode(_ type: UInt8.Type) throws -> UInt8 {
            return try value(UInt8.init)
        }

        func decode(_ type: UInt16.Type) throws -> UInt16 {
            return try value(UInt16.init)
        }

        func decode(_ type: UInt32.Type) throws -> UInt32 {
            return try value(UInt32.init)
        }

        func decode(_ type: UInt64.Type) throws -> UInt64 {
            return try value(UInt64.init)
        }

        func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
            let decoder = XMLDecoder(element: element, dateFormatters: dateFormatters)
            return try T(from: decoder)
        }
    }

}
