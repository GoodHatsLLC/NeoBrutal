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
            textPrimary: PaletteColor = PaletteColor(red: 20, green: 20, blue: 20),
            textMuted: PaletteColor = PaletteColor(red: 128, green: 128, blue: 128),
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
            windowBorderColor: PaletteColor = PaletteColor(red: 0, green: 0, blue: 0),
            windowShadowColor: PaletteColor = PaletteColor(red: 0, green: 0, blue: 0),
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
        name: String = "",
        light: Variant,
        dark: Variant? = nil
    ) {
        self.name = name
        self.light = light
        self.dark = dark ?? light
    }

    /// Convenience initializer that mirrors the original single-mode API. Optionally provide a
    /// `darkVariant` to override the automatically mirrored appearance when the environment is in
    /// dark mode.
    public init(
        name: String = "",
        background: Palette = .paper,
        surface: Palette = .paper,
        accent: Palette = .bubbleAccent,
        typography: Typography = .blocky,
        textPrimary: PaletteColor = PaletteColor(red: 20, green: 20, blue: 20),
        textMuted: PaletteColor = PaletteColor(red: 128, green: 128, blue: 128),
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
        darkVariant: Variant? = nil
    ) {
        let base = Variant(
            background: background,
            surface: surface,
            accent: accent,
            typography: typography,
            textPrimary: textPrimary,
            textMuted: textMuted,
            borderWidth: borderWidth,
            cornerRadius: cornerRadius,
            shadowOffset: shadowOffset,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity,
            noiseOpacity: noiseOpacity,
            windowButtonSize: windowButtonSize,
            windowShadowOffset: windowShadowOffset,
            windowShadowOpacity: windowShadowOpacity,
            windowRadius: windowRadius,
            windowBorder: windowBorder
        )

        self.init(name: name, light: base, dark: darkVariant)
    }

    /// Returns the variant that matches the provided color scheme. Defaults to `.light` when no scheme is provided.
    public func variant(for colorScheme: ColorScheme?) -> Variant {
        guard let colorScheme else { return light }
        return variant(for: colorScheme)
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

    public static var bubblegum: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "bubblegum",
            light: Variant(
                background: .paper,
                surface: .paper,
                accent: .bubbleAccent,
                typography: .blocky,
                textPrimary: PaletteColor(red: 18, green: 18, blue: 18),
                textMuted: PaletteColor(red: 120, green: 120, blue: 120),
                borderWidth: 2,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                noiseOpacity: 0
            ),
            dark: Variant(
                background: Palette(
                    primary: PaletteColor(red: 20, green: 22, blue: 30),
                    secondary: PaletteColor(red: 29, green: 33, blue: 44),
                    highlight: PaletteColor(red: 40, green: 45, blue: 61)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 26, green: 30, blue: 42),
                    secondary: PaletteColor(red: 39, green: 44, blue: 59),
                    highlight: PaletteColor(red: 61, green: 68, blue: 90)
                ),
                accent: Palette(
                    primary: PaletteColor(red: 255, green: 119, blue: 168),
                    secondary: PaletteColor(red: 255, green: 170, blue: 200),
                    highlight: PaletteColor(red: 139, green: 170, blue: 255)
                ),
                typography: .blocky,
                textPrimary: PaletteColor(red: 242, green: 242, blue: 248),
                textMuted: PaletteColor(red: 182, green: 186, blue: 203),
                borderWidth: 2,
                cornerRadius: 6,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                noiseOpacity: 0.3
            )
        )
    }

    public static var daybreakPlaza: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "daybreakPlaza",
            light: Variant(
                background: .morningMist,
                surface: .paper,
                accent: .sunburst,
                typography: .blocky,
                textPrimary: PaletteColor(red: 42, green: 37, blue: 32),
                textMuted: PaletteColor(red: 144, green: 125, blue: 112),
                borderWidth: 2,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                noiseOpacity: 0.05
            ),
            dark: Variant(
                background: Palette(
                    primary: PaletteColor(red: 22, green: 24, blue: 34),
                    secondary: PaletteColor(red: 33, green: 36, blue: 50),
                    highlight: PaletteColor(red: 63, green: 69, blue: 88)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 28, green: 31, blue: 44),
                    secondary: PaletteColor(red: 39, green: 42, blue: 58),
                    highlight: PaletteColor(red: 77, green: 83, blue: 106)
                ),
                accent: Palette(
                    primary: PaletteColor(red: 255, green: 157, blue: 45),
                    secondary: PaletteColor(red: 255, green: 102, blue: 128),
                    highlight: PaletteColor(red: 255, green: 182, blue: 95)
                ),
                typography: .blocky,
                textPrimary: PaletteColor(red: 239, green: 234, blue: 224),
                textMuted: PaletteColor(red: 170, green: 157, blue: 137),
                borderWidth: 2,
                cornerRadius: 6,
                shadowOffset: CGSize(width: 4, height: 4),
                shadowRadius: 10,
                shadowOpacity: 0.55,
                noiseOpacity: 0.08,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 7, height: 7),
                windowShadowOpacity: 0.6,
                windowRadius: 18,
                windowBorder: 2
            )
        )
    }

    public static var nocturneVolt: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "nocturneVolt",
            light: Variant(
                background: Palette(
                    primary: PaletteColor(red: 238, green: 244, blue: 255),
                    secondary: PaletteColor(red: 214, green: 226, blue: 255),
                    highlight: PaletteColor(red: 175, green: 214, blue: 255)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 223, green: 231, blue: 249),
                    secondary: PaletteColor(red: 199, green: 212, blue: 243),
                    highlight: PaletteColor(red: 148, green: 187, blue: 255)
                ),
                accent: .plasmaBlue,
                typography: .highContrast,
                textPrimary: PaletteColor(red: 16, green: 30, blue: 53),
                textMuted: PaletteColor(red: 82, green: 101, blue: 140),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 4, height: 4),
                shadowRadius: 8,
                shadowOpacity: 0.3,
                noiseOpacity: 0.05,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 6, height: 6),
                windowShadowOpacity: 0.35,
                windowRadius: 20,
                windowBorder: 3
            ),
            dark: Variant(
                background: .abyss,
                surface: .graphite,
                accent: .plasmaBlue,
                typography: .highContrast,
                textPrimary: PaletteColor(red: 225, green: 235, blue: 255),
                textMuted: PaletteColor(red: 129, green: 147, blue: 197),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                shadowOpacity: 0.4,
                noiseOpacity: 0.12,
                windowButtonSize: CGSize(width: 18, height: 18),
                windowShadowOffset: CGSize(width: 9, height: 9),
                windowShadowOpacity: 0.48,
                windowRadius: 20,
                windowBorder: 3
            )
        )
    }

    public static var ultravioletCargo: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "ultravioletCargo",
            light: Variant(
                background: Palette(
                    primary: PaletteColor(red: 245, green: 236, blue: 252),
                    secondary: PaletteColor(red: 233, green: 215, blue: 250),
                    highlight: PaletteColor(red: 197, green: 171, blue: 244)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 232, green: 215, blue: 244),
                    secondary: PaletteColor(red: 214, green: 193, blue: 234),
                    highlight: PaletteColor(red: 182, green: 150, blue: 224)
                ),
                accent: Palette(
                    primary: PaletteColor(red: 210, green: 64, blue: 255),
                    secondary: PaletteColor(red: 255, green: 94, blue: 188),
                    highlight: PaletteColor(red: 140, green: 82, blue: 255)
                ),
                typography: .default,
                textPrimary: PaletteColor(red: 55, green: 32, blue: 76),
                textMuted: PaletteColor(red: 120, green: 96, blue: 142),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 3, height: 3),
                shadowRadius: 8,
                shadowOpacity: 0.25,
                noiseOpacity: 0.06,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 6, height: 6),
                windowShadowOpacity: 0.35,
                windowRadius: 18,
                windowBorder: 3
            ),
            dark: Variant(
                background: .violetNight,
                surface: .midnight,
                accent: .infraSignal,
                typography: .default,
                textPrimary: PaletteColor(red: 240, green: 228, blue: 255),
                textMuted: PaletteColor(red: 165, green: 150, blue: 191),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                shadowOpacity: 0.45,
                noiseOpacity: 0.18,
                windowButtonSize: CGSize(width: 18, height: 18),
                windowShadowOffset: CGSize(width: 9, height: 9),
                windowShadowOpacity: 0.5,
                windowRadius: 18,
                windowBorder: 3
            )
        )
    }

    public static var desert: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "desert",
            light: Variant(
                background: .desert,
                surface: .desert,
                accent: .sunburst,
                typography: .default,
                textPrimary: PaletteColor(red: 42, green: 37, blue: 32),
                textMuted: PaletteColor(red: 144, green: 125, blue: 112),
                borderWidth: 2,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                shadowOpacity: 0.35,
                noiseOpacity: 0.05
            ),
            dark: Variant(
                background: Palette(
                    primary: PaletteColor(red: 32, green: 25, blue: 23),
                    secondary: PaletteColor(red: 51, green: 40, blue: 36),
                    highlight: PaletteColor(red: 74, green: 52, blue: 44)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 40, green: 33, blue: 29),
                    secondary: PaletteColor(red: 59, green: 48, blue: 41),
                    highlight: PaletteColor(red: 93, green: 72, blue: 57)
                ),
                accent: Palette(
                    primary: PaletteColor(red: 233, green: 176, blue: 73),
                    secondary: PaletteColor(red: 220, green: 132, blue: 64),
                    highlight: PaletteColor(red: 255, green: 203, blue: 115)
                ),
                typography: .default,
                textPrimary: PaletteColor(red: 243, green: 233, blue: 214),
                textMuted: PaletteColor(red: 182, green: 165, blue: 140),
                borderWidth: 2,
                cornerRadius: 4,
                shadowOffset: CGSize(width: 5, height: 5),
                shadowRadius: 10,
                shadowOpacity: 0.55,
                noiseOpacity: 0.09,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 8, height: 8),
                windowShadowOpacity: 0.62,
                windowRadius: 20,
                windowBorder: 2
            )
        )
    }

    public static var jungle: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "jungle",
            light: Variant(
                background: Palette(
                    primary: PaletteColor(red: 222, green: 242, blue: 234),
                    secondary: PaletteColor(red: 198, green: 227, blue: 212),
                    highlight: PaletteColor(red: 170, green: 210, blue: 190)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 203, green: 231, blue: 217),
                    secondary: PaletteColor(red: 175, green: 213, blue: 195),
                    highlight: PaletteColor(red: 148, green: 193, blue: 175)
                ),
                accent: Palette(
                    primary: PaletteColor(red: 83, green: 182, blue: 173),
                    secondary: PaletteColor(red: 55, green: 152, blue: 146),
                    highlight: PaletteColor(red: 117, green: 222, blue: 214)
                ),
                typography: .highContrast,
                textPrimary: PaletteColor(red: 24, green: 56, blue: 48),
                textMuted: PaletteColor(red: 78, green: 120, blue: 112),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 4, height: 4),
                shadowRadius: 8,
                shadowOpacity: 0.28,
                noiseOpacity: 0.04,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 6, height: 6),
                windowShadowOpacity: 0.33,
                windowRadius: 18,
                windowBorder: 3
            ),
            dark: Variant(
                background: .jungle,
                surface: .jungle,
                accent: .plasmaBlue,
                typography: .highContrast,
                textPrimary: PaletteColor(red: 225, green: 235, blue: 255),
                textMuted: PaletteColor(red: 129, green: 147, blue: 197),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 0,
                shadowOpacity: 0.4,
                noiseOpacity: 0.14,
                windowButtonSize: CGSize(width: 18, height: 18),
                windowShadowOffset: CGSize(width: 8, height: 8),
                windowShadowOpacity: 0.45,
                windowRadius: 20,
                windowBorder: 3
            )
        )
    }

    public static var crimsonFury: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "crimsonFury",
            light: Variant(
                background: .paper,
                surface: .paper,
                accent: .crimsonFury,
                typography: .blocky,
                textPrimary: PaletteColor(red: 20, green: 20, blue: 20),
                textMuted: PaletteColor(red: 120, green: 120, blue: 120),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 8, height: 8),
                shadowRadius: 0,
                shadowOpacity: 0.35,
                noiseOpacity: 0.18
            ),
            dark: Variant(
                background: Palette(
                    primary: PaletteColor(red: 28, green: 14, blue: 18),
                    secondary: PaletteColor(red: 44, green: 18, blue: 26),
                    highlight: PaletteColor(red: 62, green: 24, blue: 38)
                ),
                surface: Palette(
                    primary: PaletteColor(red: 36, green: 16, blue: 20),
                    secondary: PaletteColor(red: 52, green: 20, blue: 30),
                    highlight: PaletteColor(red: 79, green: 30, blue: 42)
                ),
                accent: .crimsonFury,
                typography: .blocky,
                textPrimary: PaletteColor(red: 243, green: 231, blue: 229),
                textMuted: PaletteColor(red: 194, green: 150, blue: 148),
                borderWidth: 3,
                cornerRadius: 0,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 14,
                shadowOpacity: 0.6,
                noiseOpacity: 0.22,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 9, height: 9),
                windowShadowOpacity: 0.58,
                windowRadius: 20,
                windowBorder: 3
            )
        )
    }
}

private struct NeoBrutalistThemeKey: EnvironmentKey {
    static var defaultValue: NeoBrutalistTheme { .bubblegum }
}

extension EnvironmentValues {

    public var nb: NeoBrutalistTheme.Variant {
        get {
            self.neoBrutalistTheme.variant(for: self.colorScheme)
        }
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
