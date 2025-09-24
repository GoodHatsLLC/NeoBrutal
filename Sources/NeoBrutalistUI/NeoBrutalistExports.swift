import SwiftUI

/// Convenience namespace for the Neo Brutalist component library.
public enum NeoBrutalist {
    /// Common spacing values tuned to the bold geometry of the aesthetic.
    public enum Spacing: CGFloat {
        case xsmall = 6
        case small = 12
        case medium = 18
        case large = 28
        case xlarge = 42
    }

    /// A curated list of ready-to-use themes that ship with the library.
    public static var curatedThemes: [NeoBrutalistTheme] {
        [
            .bubblegum,
            .midnightTransit,
            .citrusCircuit,
            .terminalMint
        ]
    }

    /// Returns a theme pairing suited for the current color scheme.
    public static func theme(for colorScheme: ColorScheme) -> NeoBrutalistTheme {
        switch colorScheme {
        case .light:
            return .citrusCircuit
        case .dark:
            return .midnightTransit
        @unknown default:
            return .bubblegum
        }
    }
}

public extension View {
    /// Applies a Neo Brutalist theme that adapts to the current color scheme.
    func neoBrutalistAutoThemed() -> some View {
        modifier(AutoThemedModifier())
    }
}

private struct AutoThemedModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content.neoBrutalistTheme(NeoBrutalist.theme(for: colorScheme))
    }
}
