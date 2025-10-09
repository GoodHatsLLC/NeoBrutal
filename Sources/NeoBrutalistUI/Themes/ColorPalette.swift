import SwiftUI

/// A set of related colors
public struct Palette: Equatable, Codable, Sendable {
  public var primary: PaletteColor
  public var secondary: PaletteColor
  public var highlight: PaletteColor

  public init(highlight: PaletteColor, primary: PaletteColor, secondary: PaletteColor) {
    self.primary = primary
    self.secondary = secondary
    self.highlight = highlight
  }

  public static func hierarchy(
    _ highlight: PaletteColor, _ primary: PaletteColor, _ secondary: PaletteColor
  ) -> Palette {
    .init(highlight: highlight, primary: primary, secondary: secondary)
  }
  public static func uniform(_ color: PaletteColor) -> Palette {
    .init(highlight: color, primary: color, secondary: color)
  }
}

/// A codable representation of a single color
public struct PaletteColor: Equatable, Codable, Sendable {
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double

  public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }

  public init(red: Int, green: Int, blue: Int, alpha: Double = 1) {
    self.init(
      red: Double(red) / 255,
      green: Double(green) / 255,
      blue: Double(blue) / 255,
      alpha: alpha
    )
  }

  public var color: Color {
    Color(red: red, green: green, blue: blue).opacity(alpha)
  }
}

extension PaletteColor: Swift._ExpressibleByColorLiteral {
  public init(_colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
    self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
  }
}

extension Palette {
  public var gradient: LinearGradient {
    LinearGradient(
      colors: [primary.color, secondary.color, highlight.color.opacity(0.65)],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
}
