import SwiftUI

public extension NeoBrutalistTheme {
    static var breakIdeas: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "Break Ideas",
            light: Variant(
                background: .breakIdeasBackground,
                surface: .breakIdeasBackground,
                accent: .breakIdeasAccent,
                typography: .default,
                textPrimary: ColorDescriptor(red: 0, green: 0, blue: 0),
                textMuted: ColorDescriptor(red: 128, green: 128, blue: 128),
                borderWidth: 2,
                cornerRadius: 10,
                shadowOffset: CGSize(width: 4, height: 4),
                shadowRadius: 5,
                shadowOpacity: 0.2,
                noiseOpacity: 0.05,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 6, height: 6),
                windowShadowOpacity: 0.4,
                windowRadius: 18,
                windowBorder: 2
            ),
            dark: Variant(
                background: ColorPalette(
                    primary: ColorDescriptor(red: 18, green: 18, blue: 24),
                    secondary: ColorDescriptor(red: 28, green: 28, blue: 38),
                    highlight: ColorDescriptor(red: 43, green: 41, blue: 57)
                ),
                surface: ColorPalette(
                    primary: ColorDescriptor(red: 24, green: 24, blue: 34),
                    secondary: ColorDescriptor(red: 38, green: 37, blue: 51),
                    highlight: ColorDescriptor(red: 63, green: 61, blue: 82)
                ),
                accent: ColorPalette(
                    primary: ColorDescriptor(red: 250, green: 210, blue: 0),
                    secondary: ColorDescriptor(red: 255, green: 166, blue: 77),
                    highlight: ColorDescriptor(red: 255, green: 228, blue: 138)
                ),
                typography: .default,
                textPrimary: ColorDescriptor(red: 240, green: 240, blue: 244),
                textMuted: ColorDescriptor(red: 173, green: 173, blue: 189),
                borderWidth: 2,
                cornerRadius: 10,
                shadowOffset: CGSize(width: 6, height: 6),
                shadowRadius: 14,
                shadowOpacity: 0.55,
                noiseOpacity: 0.1,
                windowButtonSize: CGSize(width: 16, height: 16),
                windowShadowOffset: CGSize(width: 8, height: 8),
                windowShadowOpacity: 0.6,
                windowRadius: 18,
                windowBorder: 2
            )
        )
    }
}
