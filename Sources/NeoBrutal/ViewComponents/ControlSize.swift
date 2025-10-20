import SwiftUI

extension ControlSize {
  var trackSize: CGSize {
    switch self {
    case .mini: CGSize(width: 52, height: 24)
    case .small: CGSize(width: 56, height: 28)
    case .regular: CGSize(width: 68, height: 34)
    case .large: CGSize(width: 86, height: 42)
    case .extraLarge: CGSize(width: 86, height: 42)
    @unknown default: CGSize(width: 68, height: 34)
    }
  }

  var spacing: CGFloat {
    switch self {
    case .mini:
      6
    case .small:
      6
    case .regular:
      8
    case .large:
      12
    case .extraLarge:
      16
    @unknown default:
      6
    }
  }
}
