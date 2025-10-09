import SwiftUI

/// A dynamic color that reads from the current NeoBrutalistTheme in the environment.
/// This allows for ergonomic color access like `.nb.background.primary` without needing @Environment.
public struct NeoBrutalistColor: ShapeStyle, @unchecked Sendable {
  let keyPath: KeyPath<NeoBrutalistTheme.Variant, PaletteColor>

  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    let theme = environment.neoBrutalistTheme
    let descriptor = theme.variant(for: environment.colorScheme)[keyPath: keyPath]
    return descriptor.color
  }

  /// Resolves to a Color value for use in APIs that require Color specifically
  public func color(in environment: EnvironmentValues) -> Color {
    let theme = environment.neoBrutalistTheme
    let descriptor = theme.variant(for: environment.colorScheme)[keyPath: keyPath]
    return descriptor.color
  }
}

/// A palette-level accessor that provides primary, secondary, and highlight variants.
public struct NeoBrutalistPaletteAccessor: @unchecked Sendable {
  let paletteKeyPath: KeyPath<NeoBrutalistTheme.Variant, Palette>

  public var primary: NeoBrutalistColor {
    NeoBrutalistColor(keyPath: paletteKeyPath.appending(path: \.primary))
  }

  public var secondary: NeoBrutalistColor {
    NeoBrutalistColor(keyPath: paletteKeyPath.appending(path: \.secondary))
  }

  public var highlight: NeoBrutalistColor {
    NeoBrutalistColor(keyPath: paletteKeyPath.appending(path: \.highlight))
  }
}

/// Namespace for accessing NeoBrutalist theme colors.
public struct NeoBrutalistColorNamespace {
  /// Background palette colors
  public var background: NeoBrutalistPaletteAccessor {
    NeoBrutalistPaletteAccessor(paletteKeyPath: \.background)
  }

  /// Surface palette colors
  public var surface: NeoBrutalistPaletteAccessor {
    NeoBrutalistPaletteAccessor(paletteKeyPath: \.surface)
  }

  /// Accent palette colors
  public var accent: NeoBrutalistPaletteAccessor {
    NeoBrutalistPaletteAccessor(paletteKeyPath: \.accent)
  }

  /// Primary text color
  public var textPrimary: NeoBrutalistColor {
    NeoBrutalistColor(keyPath: \.textPrimary)
  }

  /// Muted text color
  public var textMuted: NeoBrutalistColor {
    NeoBrutalistColor(keyPath: \.textMuted)
  }
}

extension Color {
  /// Access NeoBrutalist theme colors ergonomically.
  /// Example: `.foregroundColor(.nb.accent.primary)`
  public static var nb: NeoBrutalistColorNamespace {
    NeoBrutalistColorNamespace()
  }
}

extension ShapeStyle where Self == NeoBrutalistColor {
  /// Access NeoBrutalist theme colors as ShapeStyle.
  /// Example: `.fill(.nb.surface.primary)`
  public static var nb: NeoBrutalistColorNamespace {
    NeoBrutalistColorNamespace()
  }
}
