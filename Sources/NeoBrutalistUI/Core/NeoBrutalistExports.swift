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
            .daybreakPlaza,
            .nocturneVolt,
            .ultravioletCargo,
            .desert,
            .jungle
        ]
    }
}
