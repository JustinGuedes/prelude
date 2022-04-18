import Foundation

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public extension Sequence {
    
    func flatMap<T>(_ transform: @escaping (Element) async throws -> T?) async rethrows -> [T] {
        var result: [T] = []
        try await withThrowingTaskGroup(of: Optional<T>.self) { group in
            for element in self {
                group.addTask {
                    try await transform(element)
                }
                
                for try await newElement in group {
                    newElement.flatMap {
                        result.append($0)
                    }
                }
            }
        }
        
        return result
    }
    
}
