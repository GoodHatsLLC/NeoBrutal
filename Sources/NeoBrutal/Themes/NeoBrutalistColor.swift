import SwiftUI

/// A dynamic color that reads from the current NeoBrutalTheme in the environment.
/// This allows for ergonomic color access like `.nb.background.primary` without needing @Environment.
public struct NeoBrutalColor: ShapeStyle, @unchecked Sendable {
  let keyPath: KeyPath<NeoBrutalTheme.Variant, PaletteColor>

  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    let theme = environment.neoBrutalTheme
    let descriptor = theme.variant(for: environment.colorScheme)[keyPath: keyPath]
    return descriptor.color
  }

  /// Resolves to a Color value for use in APIs that require Color specifically
  public func color(in environment: EnvironmentValues) -> Color {
    let theme = environment.neoBrutalTheme
    let descriptor = theme.variant(for: environment.colorScheme)[keyPath: keyPath]
    return descriptor.color
  }
}

/// A palette-level accessor that provides primary, secondary, and highlight variants.
public struct NeoBrutalPaletteAccessor: @unchecked Sendable {
  let paletteKeyPath: KeyPath<NeoBrutalTheme.Variant, Palette>

  public var primary: NeoBrutalColor {
    NeoBrutalColor(keyPath: paletteKeyPath.appending(path: \.primary))
  }

  public var secondary: NeoBrutalColor {
    NeoBrutalColor(keyPath: paletteKeyPath.appending(path: \.secondary))
  }

  public var highlight: NeoBrutalColor {
    NeoBrutalColor(keyPath: paletteKeyPath.appending(path: \.highlight))
  }
}

/// Namespace for accessing NeoBrutal theme colors.
public struct NeoBrutalColorNamespace {
  /// Background palette colors
  public var background: NeoBrutalPaletteAccessor {
    NeoBrutalPaletteAccessor(paletteKeyPath: \.background)
  }

  /// Surface palette colors
  public var surface: NeoBrutalPaletteAccessor {
    NeoBrutalPaletteAccessor(paletteKeyPath: \.surface)
  }

  /// Accent palette colors
  public var accent: NeoBrutalPaletteAccessor {
    NeoBrutalPaletteAccessor(paletteKeyPath: \.accent)
  }

  /// Primary text color
  public var textPrimary: NeoBrutalColor {
    NeoBrutalColor(keyPath: \.textPrimary)
  }

  /// Muted text color
  public var textMuted: NeoBrutalColor {
    NeoBrutalColor(keyPath: \.textMuted)
  }
}

extension Color {
  /// Access NeoBrutal theme colors ergonomically.
  /// Example: `.foregroundColor(.nb.accent.primary)`
  public static var nb: NeoBrutalColorNamespace {
    NeoBrutalColorNamespace()
  }
}

extension ShapeStyle where Self == NeoBrutalColor {
  /// Access NeoBrutal theme colors as ShapeStyle.
  /// Example: `.fill(.nb.surface.primary)`
  public static var nb: NeoBrutalColorNamespace {
    NeoBrutalColorNamespace()
  }
}
