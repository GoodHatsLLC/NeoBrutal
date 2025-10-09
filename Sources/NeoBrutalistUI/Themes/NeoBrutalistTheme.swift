import SwiftUI

/// A palette-driven theme that captures the bold aesthetic of Neo Brutalism and adapts to SwiftUI
/// light and dark color schemes.
public struct NeoBrutalistTheme: Equatable, Sendable {
  /// A concrete representation of the visual system for a single `ColorScheme`.
  public struct Variant: Equatable, Sendable {
    public var background: Palette
    public var surface: Palette
    public var accent: Palette
    public var typography: Typography
    public var textPrimary: PaletteColor
    public var textMuted: PaletteColor
    public var borderWidth: CGFloat
    public var cornerRadius: CGFloat
    public var shadowOffset: CGSize
    public var shadowRadius: CGFloat
    public var shadowOpacity: CGFloat
    public var noiseOpacity: Double
    public var windowButtonSize: CGSize
    public var windowShadowOffset: CGSize
    public var windowShadowOpacity: CGFloat
    public var windowRadius: CGFloat
    public var windowBorder: CGFloat
    public var windowBorderColor: PaletteColor
    public var windowShadowColor: PaletteColor

    public init(
      background: Palette = .paper,
      surface: Palette = .paper,
      accent: Palette = .bubbleAccent,
      typography: Typography = .blocky,
      textPrimary: PaletteColor = .standardPrimaryText,
      textMuted: PaletteColor = .standardMutedText,
      borderWidth: CGFloat = 2,
      cornerRadius: CGFloat = 0,
      shadowOffset: CGSize = CGSize(width: 6, height: 6),
      shadowRadius: CGFloat = 0,
      shadowOpacity: CGFloat = 0.4,
      noiseOpacity: Double = 0.2,
      windowButtonSize: CGSize = CGSize(width: 16, height: 16),
      windowShadowOffset: CGSize = CGSize(width: 8, height: 8),
      windowShadowOpacity: CGFloat = 0.5,
      windowRadius: CGFloat = 16,
      windowBorder: CGFloat = 2,
      windowBorderColor: PaletteColor = .standardWindowBorder,
      windowShadowColor: PaletteColor = .standardWindowShadow,
    ) {
      self.background = background
      self.surface = surface
      self.accent = accent
      self.typography = typography
      self.textPrimary = textPrimary
      self.textMuted = textMuted
      self.borderWidth = borderWidth
      self.cornerRadius = cornerRadius
      self.shadowOffset = shadowOffset
      self.shadowRadius = shadowRadius
      self.shadowOpacity = shadowOpacity
      self.noiseOpacity = noiseOpacity
      self.windowButtonSize = windowButtonSize
      self.windowShadowOffset = windowShadowOffset
      self.windowShadowOpacity = windowShadowOpacity
      self.windowRadius = windowRadius
      self.windowBorder = windowBorder
      self.windowBorderColor = windowBorderColor
      self.windowShadowColor = windowShadowColor
    }
  }

  public var name: String
  public var light: Variant
  public var dark: Variant

  public init(
    name: String,
    light: Variant,
    dark: Variant
  ) {
    self.name = name
    self.light = light
    self.dark = dark ?? light
  }

  /// Returns the variant that matches the provided color scheme.
  public func variant(for colorScheme: ColorScheme) -> Variant {
    switch colorScheme {
    case .dark:
      return dark
    default:
      return light
    }
  }
}

private struct NeoBrutalistThemeKey: EnvironmentKey {
  static var defaultValue: NeoBrutalistTheme { .bubblegum }
}

extension EnvironmentValues {

  public var nb: NeoBrutalistTheme.Variant {
    self.neoBrutalistTheme.variant(for: self.colorScheme)
  }

  public var neoBrutalistTheme: NeoBrutalistTheme {
    get { self[NeoBrutalistThemeKey.self] }
    set { self[NeoBrutalistThemeKey.self] = newValue }
  }
}

extension View {
  public func neoBrutalistTheme(_ theme: NeoBrutalistTheme) -> some View {
    environment(\.neoBrutalistTheme, theme)
  }
}
