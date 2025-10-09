import SwiftUI

public struct Typography: Equatable, Sendable {
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
            titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 30),
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
