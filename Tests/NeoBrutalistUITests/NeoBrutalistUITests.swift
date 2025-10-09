import SwiftUI
import XCTest

@testable import NeoBrutalistUI

final class NeoBrutalistUITests: XCTestCase {
  func testThemeCopiesPreserveEquality() {
    let bubblegum = NeoBrutalistTheme.bubblegum
    var adjusted = bubblegum
    adjusted.light.cornerRadius = 24

    XCTAssertNotEqual(bubblegum.light.cornerRadius, adjusted.light.cornerRadius)
    XCTAssertEqual(bubblegum.light.accent, adjusted.light.accent)
  }

  func testPaletteColorNormalization() {
    let descriptor = PaletteColor(red: 255, green: 128, blue: 64)
    XCTAssertEqual(descriptor.red, 1, accuracy: 0.0001)
    XCTAssertEqual(descriptor.green, 128.0 / 255.0, accuracy: 0.0001)
    XCTAssertEqual(descriptor.blue, 64.0 / 255.0, accuracy: 0.0001)
  }
}
