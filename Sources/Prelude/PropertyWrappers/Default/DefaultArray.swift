import Foundation

public extension Array where Element: Codable {
    enum Empty: DefaultCodable {
        public static var defaultValue: Array {
            return []
        }
    }
}
