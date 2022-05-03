import Foundation

public class XMLElement {

    public let name: String
    public let attributes: [String: String]

    public var value: String?
    public var children: [XMLElement]

    init(name: String, attributes: [String: String] = [:], children: [XMLElement] = []) {
        self.name = name
        self.attributes = attributes
        self.children = children
    }

    public func child(for name: String) -> XMLElement? {
        return children.first { $0.name == name }
    }

    public func children(for name: String) -> [XMLElement] {
        return children.filter { $0.name == name }
    }

    public func attribute(for name: String) -> String? {
        return attributes[name]
    }
}
