import XCTest
@testable import SwiftMVC

final class SwiftMVCTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftMVC().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
