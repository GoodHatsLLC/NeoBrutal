import SwiftUI

public struct Typography: Equatable, Sendable {
  public var titleFont: Font
  public var bodyFont: Font
  public var monoFont: Font
  public var iconFont: Font
  public var controlFont: ControlFont

  public struct ControlFont: Equatable, Sendable {
    public init(
      name: String, mini: CGFloat = 10, small: CGFloat = 13, regular: CGFloat = 16,
      large: CGFloat = 20, extraLarge: CGFloat = 24, unknown: CGFloat = 18
    ) {
      self.name = name
      self.mini = mini
      self.small = small
      self.regular = regular
      self.large = large
      self.extraLarge = extraLarge
      self.unknown = unknown
    }
    let name: String
    let mini: CGFloat
    let small: CGFloat
    let regular: CGFloat
    let large: CGFloat
    let extraLarge: CGFloat
    let unknown: CGFloat
  }

  public func controlFont(at size: ControlSize) -> Font {
    switch size {
    case .mini:
      .neoBrutalCustom(controlFont.name, size: controlFont.mini)
    case .small:
      .neoBrutalCustom(controlFont.name, size: controlFont.small)
    case .regular:
      .neoBrutalCustom(controlFont.name, size: controlFont.regular)
    case .large:
      .neoBrutalCustom(controlFont.name, size: controlFont.large)
    case .extraLarge:
      .neoBrutalCustom(controlFont.name, size: controlFont.extraLarge)
    @unknown default:
      .neoBrutalCustom(controlFont.name, size: controlFont.unknown)
    }
  }

  public init(
    titleFont: Font,
    bodyFont: Font,
    monoFont: Font,
    iconFont: Font,
    controlFont: ControlFont
  ) {
    self.titleFont = titleFont
    self.bodyFont = bodyFont
    self.monoFont = monoFont
    self.iconFont = iconFont
    self.controlFont = controlFont
  }

  public static var `default`: Typography {
    Typography(
      titleFont: .neoBrutalCustom("CabinetGrotesk-Bold", size: 28),
      bodyFont: .neoBrutalCustom("CabinetGrotesk-Regular", size: 17),
      monoFont: .neoBrutalCustom("IBMPlexMono-Regular", size: 15),
      iconFont: .neoBrutalCustom("Inter-Medium", size: 26),
      controlFont: ControlFont(name: "CabinetGrotesk-Regular"),
    )
  }

  public static var blocky: Typography {
    Typography(
      titleFont: .neoBrutalCustom("CabinetGrotesk-Bold", size: 30),
      bodyFont: .neoBrutalCustom("Aspekta-500", size: 18),
      monoFont: .neoBrutalCustom("IBMPlexMono-Bold", size: 14),
      iconFont: .neoBrutalCustom("Inter-Medium", size: 28),
      controlFont: ControlFont(name: "Aspekta-500"),
    )
  }

  public static var highContrast: Typography {
    Typography(
      titleFont: .neoBrutalCustom("Aspekta-700", size: 32),
      bodyFont: .neoBrutalCustom("CabinetGrotesk-Medium", size: 18),
      monoFont: .neoBrutalCustom("IBMPlexMono-Regular", size: 14),
      iconFont: .neoBrutalCustom("Inter-Medium", size: 30),
      controlFont: ControlFont(name: "CabinetGrotesk-Medium"),
    )
  }

  public static var playful: Typography {
    Typography(
      titleFont: .neoBrutalCustom("CabinetGrotesk-Bold", size: 34),
      bodyFont: .neoBrutalCustom("CabinetGrotesk-Medium", size: 19),
      monoFont: .neoBrutalCustom("IBMPlexMono-Think", size: 16),
      iconFont: .neoBrutalCustom("Inter-Medium", size: 32),
      controlFont: ControlFont(name: "CabinetGrotesk-Medium"),
    )
  }
}
