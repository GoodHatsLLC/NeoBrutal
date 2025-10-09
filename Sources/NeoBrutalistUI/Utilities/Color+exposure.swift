import SwiftUI

extension Color {
  public func exposure(adjustment amount: CGFloat) -> Color {
    if #available(macOS 26, iOS 26, watchOS 26, *) {
      self.exposureAdjust(amount)
    } else {
      self
    }
  }
}
