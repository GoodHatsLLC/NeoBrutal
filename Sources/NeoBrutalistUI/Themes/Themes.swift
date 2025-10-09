// swift-format-ignore-file

import SwiftUI

extension PaletteColor {
    public static let standardWindowBorder: PaletteColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public static let standardWindowShadow: PaletteColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public static let standardPrimaryText: PaletteColor = #colorLiteral(red: 20, green: 20, blue: 20, alpha: 1)
    public static let standardMutedText: PaletteColor = #colorLiteral(red: 128, green: 128, blue: 128, alpha: 1)
}
extension Palette {
    public static let paper: Palette = .hierarchy(#colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1))
    public static let bubbleAccent: Palette = .hierarchy(#colorLiteral(red: 0.3725490196, green: 0.5529411765, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.4666666667, blue: 0.6588235294, alpha: 1),#colorLiteral(red: 1, green: 0.6666666667, blue: 0.7843137255, alpha: 1))
}

extension NeoBrutalistTheme {
    public static var bubblegum: NeoBrutalistTheme {
       NeoBrutalistTheme(
         name: "bubblegum",
         light: Variant(
           background: .paper,
           surface: .paper,
           accent: .bubbleAccent,
           typography: .blocky,
           textPrimary: #colorLiteral(red: 0.0705882353, green: 0.0705882353, blue: 0.0705882353, alpha: 1),
           textMuted: #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1),
           borderWidth: 2,
           cornerRadius: 0,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 0,
           noiseOpacity: 0
         ),
         dark: Variant(
            background: .hierarchy(#colorLiteral(red: 0.1568627451, green: 0.1764705882, blue: 0.2392156863, alpha: 1),#colorLiteral(red: 0.0784313725, green:0.0862745098, blue: 0.1176470588, alpha: 1),#colorLiteral(red: 0.1137254902, green: 0.1294117647, blue: 0.1725490196, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 0.2392156863, green: 0.2666666667, blue: 0.3529411765, alpha: 1),#colorLiteral(red: 0.1019607843, green: 0.1176470588, blue: 0.1647058824, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.1725490196, blue: 0.231372549, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 0.5450980392, green: 0.6666666667, blue: 1.0, alpha: 1),#colorLiteral(red: 1.0, green: 0.4666666667, blue: 0.6588235294, alpha: 1),#colorLiteral(red: 1.0, green: 0.6666666667, blue: 0.7843137255, alpha: 1)),
           typography: .blocky,
           textPrimary: #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9725490196, alpha: 1),
           textMuted: #colorLiteral(red: 0.7137254902, green: 0.7294117647, blue: 0.7960784314, alpha: 1),
           borderWidth: 2,
           cornerRadius: 6,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 0,
           noiseOpacity: 0.3
         )
       )
     }}

infix operator  ↴ : BitwiseShiftPrecedence

func  ↴ (lhs: some BinaryInteger, rhs: some BinaryInteger) -> CGSize {
    CGSize(width: Double(lhs), height: Double(rhs))
}

