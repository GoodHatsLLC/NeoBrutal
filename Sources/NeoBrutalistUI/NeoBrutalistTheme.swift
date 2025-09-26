import SwiftUI

/// A palette-driven theme that captures the bold aesthetic of Neo Brutalism.
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
    public var noiseOpacity: Double
    public var windowButtonSize: CGSize

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
        noiseOpacity: Double = 0,
        windowButtonSize: CGSize = CGSize(width: 16, height: 16)
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
        self.noiseOpacity = noiseOpacity
        self.windowButtonSize = windowButtonSize
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
}

public struct ColorPalette: Equatable {
    public var primary: ColorDescriptor
    public var secondary: ColorDescriptor
    public var highlight: ColorDescriptor

    public init(primary: ColorDescriptor, secondary: ColorDescriptor, highlight: ColorDescriptor) {
        self.primary = primary
        self.secondary = secondary
        self.highlight = highlight
    }

    public static var paper: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 255, blue: 255),
            secondary: ColorDescriptor(red: 244, green: 244, blue: 244),
            highlight: ColorDescriptor(red: 228, green: 228, blue: 228)
        )
    }

    public static var bubbleAccent: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 119, blue: 168),
            secondary: ColorDescriptor(red: 255, green: 170, blue: 200),
            highlight: ColorDescriptor(red: 95, green: 141, blue: 255)
        )
    }

    public static var midnight: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 8, green: 14, blue: 31),
            secondary: ColorDescriptor(red: 16, green: 28, blue: 53),
            highlight: ColorDescriptor(red: 46, green: 219, blue: 255)
        )
    }

    public static var graphite: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 30, green: 46, blue: 72),
            secondary: ColorDescriptor(red: 47, green: 70, blue: 104),
            highlight: ColorDescriptor(red: 142, green: 185, blue: 255)
        )
    }

    public static var bone: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 239, green: 236, blue: 222),
            secondary: ColorDescriptor(red: 221, green: 217, blue: 203),
            highlight: ColorDescriptor(red: 255, green: 196, blue: 0)
        )
    }

    public static var concrete: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 217, green: 220, blue: 226),
            secondary: ColorDescriptor(red: 189, green: 193, blue: 201),
            highlight: ColorDescriptor(red: 74, green: 88, blue: 102, alpha: 0.35)
        )
    }

    public static var charcoal: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 25, green: 26, blue: 34),
            secondary: ColorDescriptor(red: 36, green: 38, blue: 48),
            highlight: ColorDescriptor(red: 78, green: 238, blue: 180)
        )
    }

    public static var electricBlue: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 64, green: 133, blue: 255),
            secondary: ColorDescriptor(red: 41, green: 102, blue: 246),
            highlight: ColorDescriptor(red: 56, green: 255, blue: 212)
        )
    }

    public static var sherbet: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 219, blue: 205),
            secondary: ColorDescriptor(red: 255, green: 198, blue: 185),
            highlight: ColorDescriptor(red: 255, green: 156, blue: 173)
        )
    }

    public static var magenta: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 214, green: 36, blue: 156),
            secondary: ColorDescriptor(red: 255, green: 56, blue: 185),
            highlight: ColorDescriptor(red: 255, green: 243, blue: 0)
        )
    }

    public static var emeraldPulse: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 78, green: 236, blue: 189),
            secondary: ColorDescriptor(red: 48, green: 204, blue: 156),
            highlight: ColorDescriptor(red: 180, green: 255, blue: 228)
        )
    }

    public static var morningMist: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 252, green: 247, blue: 237),
            secondary: ColorDescriptor(red: 242, green: 234, blue: 219),
            highlight: ColorDescriptor(red: 255, green: 212, blue: 144)
        )
    }

    public static var pastelSky: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 243, green: 247, blue: 255),
            secondary: ColorDescriptor(red: 226, green: 234, blue: 252),
            highlight: ColorDescriptor(red: 184, green: 209, blue: 255)
        )
    }

    public static var citrusSpark: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 207, blue: 96),
            secondary: ColorDescriptor(red: 255, green: 173, blue: 68),
            highlight: ColorDescriptor(red: 255, green: 102, blue: 146)
        )
    }

    public static var sunburst: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 157, blue: 45),
            secondary: ColorDescriptor(red: 255, green: 102, blue: 128),
            highlight: ColorDescriptor(red: 0, green: 200, blue: 96)
        )
    }

    public static var abyss: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 10, green: 15, blue: 32),
            secondary: ColorDescriptor(red: 22, green: 30, blue: 55),
            highlight: ColorDescriptor(red: 108, green: 236, blue: 255)
        )
    }

    public static var plasmaBlue: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 64, green: 194, blue: 235),
            secondary: ColorDescriptor(red: 42, green: 115, blue: 245),
            highlight: ColorDescriptor(red: 95, green: 255, blue: 234)
        )
    }

    public static var violetNight: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 33, green: 18, blue: 48),
            secondary: ColorDescriptor(red: 54, green: 32, blue: 76),
            highlight: ColorDescriptor(red: 136, green: 78, blue: 255)
        )
    }

    public static var infraSignal: ColorPalette {
        ColorPalette(
            primary: ColorDescriptor(red: 255, green: 64, blue: 119),
            secondary: ColorDescriptor(red: 214, green: 45, blue: 174),
            highlight: ColorDescriptor(red: 255, green: 209, blue: 104)
        )
    }
}
public struct ColorDescriptor: Equatable, Codable {
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

extension ColorPalette {
    public var gradient: LinearGradient {
        LinearGradient(
            colors: [primary.color, secondary.color, highlight.color.opacity(0.65)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

public struct Typography: Equatable {
    public var titleFont: Font
    public var bodyFont: Font
    public var monoFont: Font

    public init(titleFont: Font, bodyFont: Font, monoFont: Font) {
        self.titleFont = titleFont
        self.bodyFont = bodyFont
        self.monoFont = monoFont
    }

    public static var `default`: Typography {
        Typography(
            titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 28),
            bodyFont: .neoBrutalistCustom("CabinetGrotesk-Regular", size: 17),
            monoFont: .neoBrutalistCustom("IBMPlexMono-Regular", size: 15)
        )
    }

    public static var blocky: Typography {
        Typography(
            titleFont: .neoBrutalistCustom("Aspekta-700", size: 30),
            bodyFont: .neoBrutalistCustom("Aspekta-500", size: 18),
            monoFont: .neoBrutalistCustom("IBMPlexMono-Bold", size: 14)
        )
    }

    public static var highContrast: Typography {
        Typography(
            titleFont: .neoBrutalistCustom("Aspekta-700", size: 32),
            bodyFont: .neoBrutalistCustom("CabinetGrotesk-Medium", size: 18),
            monoFont: .neoBrutalistCustom("IBMPlexMono-Regular", size: 14)
        )
    }

    public static var playful: Typography {
        Typography(
            titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 34),
            bodyFont: .neoBrutalistCustom("CabinetGrotesk-Medium", size: 19),
            monoFont: .neoBrutalistCustom("IBMPlexMono-Think", size: 16)
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
