import XCTest
import SwiftUI
@testable import NeoBrutalistUI

final class NeoBrutalistUITests: XCTestCase {
    func testThemeCopiesPreserveEquality() {
        let bubblegum = NeoBrutalistTheme.bubblegum
        var adjusted = bubblegum
        adjusted.cornerRadius = 24

        XCTAssertNotEqual(bubblegum.cornerRadius, adjusted.cornerRadius)
        XCTAssertEqual(bubblegum.accent, adjusted.accent)
    }

    func testColorDescriptorNormalization() {
        let descriptor = ColorDescriptor(red: 255, green: 128, blue: 64)
        XCTAssertEqual(descriptor.red, 1, accuracy: 0.0001)
        XCTAssertEqual(descriptor.green, 128.0 / 255.0, accuracy: 0.0001)
        XCTAssertEqual(descriptor.blue, 64.0 / 255.0, accuracy: 0.0001)
    }
}
