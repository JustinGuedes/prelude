import Foundation

public extension Array {
    
    func split(chunkSize: Int) -> [[Element]] {
        if count <= chunkSize {
            return [self]
        } else {
            return [Array(self[0..<chunkSize])]
            + Array(self[chunkSize..<count])
                .split(chunkSize: chunkSize)
        }
    }
    
}
