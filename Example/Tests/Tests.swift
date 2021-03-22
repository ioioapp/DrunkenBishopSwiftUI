import XCTest
@testable import DrunkenBishop

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let bishop = DrunkenBishop()
        let text = "308204BC020100300DeF7aaaa787899"
        print(bishop.representation(from: text))
    }
    
    func testExample2() {
        let bishop = DrunkenBishop()
        let text = "308204BC020100300DeF7aaaa787899aaaaaaaaa"
        print(bishop.representation(from: text))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
