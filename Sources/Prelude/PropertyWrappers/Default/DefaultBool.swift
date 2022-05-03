import Foundation

public extension Bool {
    enum True: DefaultCodable {
        public static var defaultValue: Bool {
            return true
        }
    }

    enum False: DefaultCodable {
        public static var defaultValue: Bool {
            return false
        }
    }
}
