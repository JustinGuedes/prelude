import XCTest

import Prelude

@available(iOS 13.0, *)
class SequenceTests: XCTestCase {
    
    func testFlatMapAwaitsAsyncTransformer() async throws {
        let input = [1, 2, 3]
        let expectedOutput = [4]
        
        let output = await input.flatMap(power)
        
        XCTAssertEqual(expectedOutput, output)
    }
    
}

@available(iOS 13.0, *)
extension SequenceTests {
    
    func power(_ value: Int) async -> Int? {
        let newValue = value * value
        guard newValue % 2 == 0 else {
            return nil
        }
        
        return newValue
    }
    
}
