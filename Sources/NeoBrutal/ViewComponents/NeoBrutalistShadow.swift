import CoreGraphics
import Foundation
import SwiftUI

extension View {

  /// Applies a hard-edged shadow when the theme requests a zero-radius drop shadow.
  public func neoBrutalShadow(
    color: Color, radius: CGFloat, offset: CGSize, clip: Axis? = nil, isEnabled: Bool = true,
    cornerRadius: CGFloat = 0
  ) -> some View {
    modifier(
      NeoBrutalShadowModifier(
        color: color,
        radius: radius,
        offset: offset,
        clip: clip,
        isEnabled: isEnabled,
        cornerRadius: cornerRadius
      )
    )
  }
}

private struct NeoBrutalShadowModifier: ViewModifier, Sendable {
  let color: Color
  let radius: CGFloat
  let offset: CGSize
  let clip: Axis?
  let isEnabled: Bool
  let cornerRadius: CGFloat
  var modOffset: CGSize { isEnabled ? offset : .zero }

  @ViewBuilder
  func body(content: Content) -> some View {
    if radius <= 0 {
      content
        .background {
          RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(color)
            .offset(x: modOffset.width, y: modOffset.height)
        }
    } else {
      content.shadow(
        color: color,
        radius: radius,
        x: modOffset.width,
        y: modOffset.height
      )

    }
  }
}
