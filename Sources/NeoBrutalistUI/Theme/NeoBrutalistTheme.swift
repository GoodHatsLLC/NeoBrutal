import SwiftUI

/// A palette-driven theme that captures the bold aesthetic of Neo Brutalism.
import SwiftUI

public struct NeoBrutalistTheme: Equatable {
    public var name: String
    public var background: ColorPalette
    public var surface: ColorPalette
    public var accent: ColorPalette
    public var typography: Typography
    public var textPrimary: ColorDescriptor
    public var textMuted: ColorDescriptor
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

    public init(
        name: String = "",
        background: ColorPalette = .paper,
        surface: ColorPalette = .paper,
        accent: ColorPalette = .bubbleAccent,
        typography: Typography = .blocky,
        textPrimary: ColorDescriptor = ColorDescriptor(red: 20, green: 20, blue: 20),
        textMuted: ColorDescriptor = ColorDescriptor(red: 128, green: 128, blue: 128),
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
        windowBorder: CGFloat = 2
    ) {
        self.name = name
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
    }

    public static var bubblegum: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .paper,
            surface: .paper,
            accent: .bubbleAccent,
            typography: .blocky,
            textPrimary: ColorDescriptor(red: 18, green: 18, blue: 18),
            textMuted: ColorDescriptor(red: 120, green: 120, blue: 120),
            borderWidth: 2,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0
        )
    }

    public static var daybreakPlaza: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .morningMist,
            surface: .paper,
            accent: .sunburst,
            typography: .blocky,
            textPrimary: ColorDescriptor(red: 42, green: 37, blue: 32),
            textMuted: ColorDescriptor(red: 144, green: 125, blue: 112),
            borderWidth: 2,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0.05
        )
    }

    public static var nocturneVolt: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .abyss,
            surface: .graphite,
            accent: .plasmaBlue,
            typography: .highContrast,
            textPrimary: ColorDescriptor(red: 225, green: 235, blue: 255),
            textMuted: ColorDescriptor(red: 129, green: 147, blue: 197),
            borderWidth: 3,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0.14
        )
    }

    public static var ultravioletCargo: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .violetNight,
            surface: .midnight,
            accent: .infraSignal,
            typography: .default,
            textPrimary: ColorDescriptor(red: 240, green: 228, blue: 255),
            textMuted: ColorDescriptor(red: 165, green: 150, blue: 191),
            borderWidth: 3,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0.18
        )
    }

    public static var desert: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .desert,
            surface: .desert,
            accent: .sunburst,
            typography: .default,
            textPrimary: ColorDescriptor(red: 42, green: 37, blue: 32),
            textMuted: ColorDescriptor(red: 144, green: 125, blue: 112),
            borderWidth: 2,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0.05
        )
    }

    public static var jungle: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .jungle,
            surface: .jungle,
            accent: .plasmaBlue,
            typography: .highContrast,
            textPrimary: ColorDescriptor(red: 225, green: 235, blue: 255),
            textMuted: ColorDescriptor(red: 129, green: 147, blue: 197),
            borderWidth: 3,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 6, height: 6),
            shadowRadius: 0,
            noiseOpacity: 0.14
        )
    }

    public static var crimsonFury: NeoBrutalistTheme {
        NeoBrutalistTheme(
            background: .paper,
            surface: .paper,
            accent: .crimsonFury,
            typography: .blocky,
            textPrimary: ColorDescriptor(red: 20, green: 20, blue: 20),
            textMuted: ColorDescriptor(red: 120, green: 120, blue: 120),
            borderWidth: 3,
            cornerRadius: 0,
            shadowOffset: CGSize(width: 8, height: 8),
            shadowRadius: 0,
            noiseOpacity: 0.25
        )
    }
}

private struct NeoBrutalistThemeKey: EnvironmentKey {
    static var defaultValue: NeoBrutalistTheme { .bubblegum }
}

extension EnvironmentValues {
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
