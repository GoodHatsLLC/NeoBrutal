import SwiftUI

public extension NeoBrutalistTheme {
    static var breakIdeas: NeoBrutalistTheme {
        NeoBrutalistTheme(
            name: "Break Ideas",
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
            noiseOpacity: 0.05,
            windowButtonSize: CGSize(width: 16, height: 16)
        )
    }
}
