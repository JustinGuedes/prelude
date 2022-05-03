import Foundation

public class XMLElementParser: NSObject, XMLParserDelegate {

    private var document: XMLElement
    private var path: [XMLElement]
    private var error: Error?

    public override init() {
        document = XMLElement(name: "document")
        path = []
    }

    public func parse(_ data: Data) throws -> XMLElement {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        if let error = error {
            throw error
        }

        return document
    }

    public func parserDidStartDocument(_ parser: XMLParser) {
        path = [document]
    }

    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        let parent = path.last
        let element = XMLElement(name: elementName, attributes: attributeDict)
        parent?.children.append(element)
        path.append(element)
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let element = path.last
        element?.value = string
    }

    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        let element = path.last
        element?.value = String(data: CDATABlock, encoding: .utf8)
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        path.removeLast()
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        error = parseError
    }

    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        error = validationError
    }

}
