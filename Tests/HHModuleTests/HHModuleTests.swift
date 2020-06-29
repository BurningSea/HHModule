import XCTest
@testable import HHModule

final class HHModuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HHModule().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
