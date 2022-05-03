import Foundation

public protocol DefaultCodable {
    associatedtype ValueType: Codable
    static var defaultValue: ValueType { get }
}
