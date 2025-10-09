import SwiftUI

public struct Typography: Equatable, Sendable {
  public var titleFont: Font
  public var bodyFont: Font
  public var monoFont: Font
  public var iconFont: Font

  public init(titleFont: Font, bodyFont: Font, monoFont: Font, iconFont: Font) {
    self.titleFont = titleFont
    self.bodyFont = bodyFont
    self.monoFont = monoFont
    self.iconFont = iconFont
  }

  public static var `default`: Typography {
    Typography(
      titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 28),
      bodyFont: .neoBrutalistCustom("CabinetGrotesk-Regular", size: 17),
      monoFont: .neoBrutalistCustom("IBMPlexMono-Regular", size: 15),
      iconFont: .neoBrutalistCustom("Inter-Medium", size: 26)
    )
  }

  public static var blocky: Typography {
    Typography(
      titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 30),
      bodyFont: .neoBrutalistCustom("Aspekta-500", size: 18),
      monoFont: .neoBrutalistCustom("IBMPlexMono-Bold", size: 14),
      iconFont: .neoBrutalistCustom("Inter-Medium", size: 28)
    )
  }

  public static var highContrast: Typography {
    Typography(
      titleFont: .neoBrutalistCustom("Aspekta-700", size: 32),
      bodyFont: .neoBrutalistCustom("CabinetGrotesk-Medium", size: 18),
      monoFont: .neoBrutalistCustom("IBMPlexMono-Regular", size: 14),
      iconFont: .neoBrutalistCustom("Inter-Medium", size: 30)
    )
  }

  public static var playful: Typography {
    Typography(
      titleFont: .neoBrutalistCustom("CabinetGrotesk-Bold", size: 34),
      bodyFont: .neoBrutalistCustom("CabinetGrotesk-Medium", size: 19),
      monoFont: .neoBrutalistCustom("IBMPlexMono-Think", size: 16),
      iconFont: .neoBrutalistCustom("Inter-Medium", size: 32)
    )
  }
}
