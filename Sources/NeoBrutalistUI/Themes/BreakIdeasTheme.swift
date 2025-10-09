// swift-format-ignore-file: LineLength
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
    public static let bone: Palette = .hierarchy(#colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),#colorLiteral(red: 0.937254902, green: 0.9254901961, blue: 0.8705882353, alpha: 1),#colorLiteral(red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1))
    public static let concrete: Palette = .hierarchy(#colorLiteral(red: 0.2901960784, green: 0.3450980392, blue: 0.4, alpha: 0.35),#colorLiteral(red: 0.8509803922, green: 0.862745098, blue: 0.8862745098, alpha: 1),#colorLiteral(red: 0.7411764706, green: 0.7568627451, blue: 0.7882352941, alpha: 1))
    public static let charcoal: Palette = .hierarchy(#colorLiteral(red: 0.3058823529, green: 0.9333333333, blue: 0.7058823529, alpha: 1),#colorLiteral(red: 0.0980392157, green: 0.1019607843, blue: 0.1333333333, alpha: 1),#colorLiteral(red: 0.1411764706, green: 0.1490196078, blue: 0.1882352941, alpha: 1))
    public static let electricBlue: Palette = .hierarchy(#colorLiteral(red: 0.2196078431, green: 1, blue: 0.831372549, alpha: 1),#colorLiteral(red: 0.2509803922, green: 0.5215686275, blue: 1, alpha: 1),#colorLiteral(red: 0.1607843137, green: 0.4, blue: 0.9647058824, alpha: 1))
    public static let sherbet: Palette = .hierarchy(#colorLiteral(red: 1, green: 0.6117647059, blue: 0.6784313725, alpha: 1),#colorLiteral(red: 1, green: 0.8588235294, blue: 0.8039215686, alpha: 1),#colorLiteral(red: 1, green: 0.7764705882, blue: 0.7254901961, alpha: 1))
    public static let magenta: Palette = .hierarchy(#colorLiteral(red: 1, green: 0.9529411765, blue: 0, alpha: 1),#colorLiteral(red: 0.8392156863, green: 0.1411764706, blue: 0.6117647059, alpha: 1),#colorLiteral(red: 1, green: 0.2196078431, blue: 0.7254901961, alpha: 1))
    public static let emeraldPulse: Palette = .hierarchy(#colorLiteral(red: 0.7058823529, green: 1, blue: 0.8941176471, alpha: 1),#colorLiteral(red: 0.3058823529, green: 0.9254901961, blue: 0.7411764706, alpha: 1),#colorLiteral(red: 0.1882352941, green: 0.8, blue: 0.6117647059, alpha: 1))
    public static let morningMist: Palette = .hierarchy(#colorLiteral(red: 1, green: 0.831372549, blue: 0.5647058824, alpha: 1),#colorLiteral(red: 0.9882352941, green: 0.968627451, blue: 0.9294117647, alpha: 1),#colorLiteral(red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1))
    public static let pastelSky: Palette = .hierarchy(#colorLiteral(red: 0.7215686275, green: 0.8196078431, blue: 1, alpha: 1),#colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1),#colorLiteral(red: 0.8862745098, green: 0.9176470588, blue: 0.9882352941, alpha: 1))
    public static let citrusSpark: Palette = .hierarchy(#colorLiteral(red: 1, green: 0.4, blue: 0.5725490196, alpha: 1),#colorLiteral(red: 1, green: 0.8117647059, blue: 0.3764705882, alpha: 1),#colorLiteral(red: 1, green: 0.6784313725, blue: 0.2666666667, alpha: 1))
    public static let plasmaBlue: Palette = .hierarchy(#colorLiteral(red: 0.3725490196, green: 1, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0.2509803922, green: 0.7607843137, blue: 0.9215686275, alpha: 1),#colorLiteral(red: 0.1647058824, green: 0.4509803922, blue: 0.9607843137, alpha: 1))
}

extension NeoBrutalistTheme {

  public static var breakIdeas: NeoBrutalistTheme {
    NeoBrutalistTheme(
      name: "Break Ideas",
      light: Variant(
        background: .uniform(#colorLiteral(red: 0.9921568627, green: 0.9882352941, blue: 0.9843137255, alpha: 1)),
        surface: .uniform(#colorLiteral(red: 0.8980392157, green: 0.5333333333, blue: 0.6392156863, alpha: 1)),
        accent: .uniform(#colorLiteral(red: 0.9529411765, green: 0.8274509804, blue: 0, alpha: 1)),
        typography: .default,
        textPrimary: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        textMuted: #colorLiteral(red: 128, green: 128, blue: 128, alpha: 1),
        borderWidth: 2,
        cornerRadius: 10,
        shadowOffset: 4 ↴ 4,
        shadowRadius: 5,
        shadowOpacity: 0.2,
        noiseOpacity: 0.05,
        windowButtonSize: 16 ↴ 16,
        windowShadowOffset: 6 ↴ 6,
        windowShadowOpacity: 0.4,
        windowRadius: 18,
        windowBorder: 2
      ),
      dark: Variant(
        background: .hierarchy(#colorLiteral(red: 43, green: 41, blue: 57, alpha: 1),#colorLiteral(red: 18, green: 18, blue: 24, alpha: 1),#colorLiteral(red: 28, green: 28, blue: 38, alpha: 1)),
        surface: .hierarchy(#colorLiteral(red: 63, green: 61, blue: 82, alpha: 1),#colorLiteral(red: 24, green: 24, blue: 34, alpha: 1),#colorLiteral(red: 38, green: 37, blue: 51, alpha: 1)),
        accent: .hierarchy(#colorLiteral(red: 255, green: 228, blue: 138, alpha: 1),#colorLiteral(red: 250, green: 210, blue: 0, alpha: 1),#colorLiteral(red: 255, green: 166, blue: 77, alpha: 1)),
        typography: .default,
        textPrimary: #colorLiteral(red: 240, green: 240, blue: 244, alpha: 1),
        textMuted: #colorLiteral(red: 173, green: 173, blue: 189, alpha: 1),
        borderWidth: 2,
        cornerRadius: 10,
        shadowOffset: 6 ↴ 6,
        shadowRadius: 14,
        shadowOpacity: 0.55,
        noiseOpacity: 0.1,
        windowButtonSize: 16 ↴ 16,
        windowShadowOffset: 8 ↴ 8,
        windowShadowOpacity: 0.6,
        windowRadius: 18,
        windowBorder: 2
      )
    )
  }
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
     }


    public static var daybreakPlaza: NeoBrutalistTheme {
      NeoBrutalistTheme(
        name: "daybreakPlaza",
        light: Variant(
          background: .morningMist,
          surface: .paper,
          accent: .hierarchy(#colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),#colorLiteral(red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1),#colorLiteral(red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1)),
          typography: .blocky,
          textPrimary: #colorLiteral(red: 42, green: 37, blue: 32, alpha: 1),
          textMuted: #colorLiteral(red: 144, green: 125, blue: 112, alpha: 1),
          borderWidth: 2,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 0,
          noiseOpacity: 0.05
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 63, green: 69, blue: 8, alpha: 18),#colorLiteral(red: 22, green: 24, blue: 34, alpha: 1),#colorLiteral(red: 33, green: 36, blue: 50, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 77, green: 83, blue: 10, alpha: 16),#colorLiteral(red: 28, green: 31, blue: 44, alpha: 1),#colorLiteral(red: 39, green: 42, blue: 58, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 255, green: 182, blue: 9, alpha: 15),#colorLiteral(red: 255, green: 157, blue: 45, alpha: 1),#colorLiteral(red: 255, green: 102, blue: 128, alpha: 1)),
          typography: .blocky,
          textPrimary: #colorLiteral(red: 239, green: 234, blue: 224, alpha: 1),
          textMuted: #colorLiteral(red: 170, green: 157, blue: 137, alpha: 1),
          borderWidth: 2,
          cornerRadius: 6,
          shadowOffset: 4 ↴ 4,
          shadowRadius: 10,
          shadowOpacity: 0.55,
          noiseOpacity: 0.08,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 7 ↴ 7,
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
            background: .hierarchy(#colorLiteral(red: 175, green: 214, blue: 25, alpha: 15),#colorLiteral(red: 238, green: 244, blue: 255, alpha: 1),#colorLiteral(red: 214, green: 226, blue: 255, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 148, green: 187, blue: 25, alpha: 15),#colorLiteral(red: 223, green: 231, blue: 249, alpha: 1),#colorLiteral(red: 199, green: 212, blue: 243, alpha: 1)),
          accent: .plasmaBlue,
          typography: .highContrast,
          textPrimary: #colorLiteral(red: 16, green: 30, blue: 53, alpha: 1),
          textMuted: #colorLiteral(red: 82, green: 101, blue: 140, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 4 ↴ 4,
          shadowRadius: 8,
          shadowOpacity: 0.3,
          noiseOpacity: 0.05,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 6 ↴ 6,
          windowShadowOpacity: 0.35,
          windowRadius: 20,
          windowBorder: 3
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 0.4235294118, green: 0.9254901961, blue: 1, alpha: 1),#colorLiteral(red: 0.0392156863, green: 0.0588235294, blue: 0.1254901961, alpha: 1),#colorLiteral(red: 0.0862745098, green: 0.1176470588, blue: 0.2156862745, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 0.5568627451, green: 0.7254901961, blue: 1, alpha: 1),#colorLiteral(red: 0.1176470588, green: 0.1803921569, blue: 0.2823529412, alpha: 1),#colorLiteral(red: 0.1843137255, green: 0.2745098039, blue: 0.4078431373, alpha: 1)),
          accent: .plasmaBlue,
          typography: .highContrast,
          textPrimary: #colorLiteral(red: 225, green: 235, blue: 255, alpha: 1),
          textMuted: #colorLiteral(red: 129, green: 147, blue: 197, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 0,
          shadowOpacity: 0.4,
          noiseOpacity: 0.12,
          windowButtonSize: 18 ↴ 18,
          windowShadowOffset: 9 ↴ 9,
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
            background: .hierarchy(#colorLiteral(red: 197, green: 171, blue: 24, alpha: 14),#colorLiteral(red: 245, green: 236, blue: 252, alpha: 1),#colorLiteral(red: 233, green: 215, blue: 250, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 182, green: 150, blue: 22, alpha: 14),#colorLiteral(red: 232, green: 215, blue: 244, alpha: 1),#colorLiteral(red: 214, green: 193, blue: 234, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 140, green: 82, blue: 25, alpha: 15),#colorLiteral(red: 210, green: 64, blue: 255, alpha: 1),#colorLiteral(red: 255, green: 94, blue: 188, alpha: 1)),
          typography: .default,
          textPrimary: #colorLiteral(red: 55, green: 32, blue: 76, alpha: 1),
          textMuted: #colorLiteral(red: 120, green: 96, blue: 142, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 3 ↴ 3,
          shadowRadius: 8,
          shadowOpacity: 0.25,
          noiseOpacity: 0.06,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 6 ↴ 6,
          windowShadowOpacity: 0.35,
          windowRadius: 18,
          windowBorder: 3
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 0.5333333333, green: 0.3058823529, blue: 1, alpha: 1),#colorLiteral(red: 0.1294117647, green: 0.0705882353, blue: 0.1882352941, alpha: 1),#colorLiteral(red: 0.2117647059, green: 0.1254901961, blue: 0.2980392157, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 0.1803921569, green: 0.8588235294, blue: 1, alpha: 1),#colorLiteral(red: 0.031372549, green: 0.0549019608, blue: 0.1215686275, alpha: 1),#colorLiteral(red: 0.062745098, green: 0.1098039216, blue: 0.2078431373, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 1, green: 0.8196078431, blue: 0.4078431373, alpha: 1),#colorLiteral(red: 1, green: 0.2509803922, blue: 0.4666666667, alpha: 1),#colorLiteral(red: 0.8392156863, green: 0.1764705882, blue: 0.6823529412, alpha: 1)),
          typography: .default,
          textPrimary: #colorLiteral(red: 240, green: 228, blue: 255, alpha: 1),
          textMuted: #colorLiteral(red: 165, green: 150, blue: 191, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 0,
          shadowOpacity: 0.45,
          noiseOpacity: 0.18,
          windowButtonSize: 18 ↴ 18,
          windowShadowOffset: 9 ↴ 9,
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
            background: .hierarchy(#colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),#colorLiteral(red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1),#colorLiteral(red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1)),
          surface: .hierarchy(#colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1),#colorLiteral(red: 0.9490196078, green: 0.9176470588, blue: 0.8588235294, alpha: 1),#colorLiteral(red: 0.8666666667, green: 0.8509803922, blue: 0.7960784314, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 0, green: 0.7843137255, blue: 0.3764705882, alpha: 1),#colorLiteral(red: 1, green: 0.6156862745, blue: 0.1764705882, alpha: 1),#colorLiteral(red: 1, green: 0.4, blue: 0.5019607843, alpha: 1)),
          typography: .default,
          textPrimary: #colorLiteral(red: 42, green: 37, blue: 32, alpha: 1),
          textMuted: #colorLiteral(red: 144, green: 125, blue: 112, alpha: 1),
          borderWidth: 2,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 0,
          shadowOpacity: 0.35,
          noiseOpacity: 0.05
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 74, green: 52, blue: 4, alpha: 14),#colorLiteral(red: 32, green: 25, blue: 23, alpha: 1),#colorLiteral(red: 51, green: 40, blue: 36, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 93, green: 72, blue: 5, alpha: 17),#colorLiteral(red: 40, green: 33, blue: 29, alpha: 1),#colorLiteral(red: 59, green: 48, blue: 41, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 255, green: 203, blue: 11, alpha: 15),#colorLiteral(red: 233, green: 176, blue: 73, alpha: 1),#colorLiteral(red: 220, green: 132, blue: 64, alpha: 1)),
          typography: .default,
          textPrimary: #colorLiteral(red: 243, green: 233, blue: 214, alpha: 1),
          textMuted: #colorLiteral(red: 182, green: 165, blue: 140, alpha: 1),
          borderWidth: 2,
          cornerRadius: 4,
          shadowOffset: 5 ↴ 5,
          shadowRadius: 10,
          shadowOpacity: 0.55,
          noiseOpacity: 0.09,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 8 ↴ 8,
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
            background: .hierarchy(#colorLiteral(red: 170, green: 210, blue: 19, alpha: 10),#colorLiteral(red: 222, green: 242, blue: 234, alpha: 1),#colorLiteral(red: 198, green: 227, blue: 212, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 148, green: 193, blue: 17, alpha: 15),#colorLiteral(red: 203, green: 231, blue: 217, alpha: 1),#colorLiteral(red: 175, green: 213, blue: 195, alpha: 1)),
            accent: .hierarchy(#colorLiteral(red: 117, green: 222, blue: 21, alpha: 14),#colorLiteral(red: 83, green: 182, blue: 173, alpha: 1),#colorLiteral(red: 55, green: 152, blue: 146, alpha: 1)),
          typography: .highContrast,
          textPrimary: #colorLiteral(red: 24, green: 56, blue: 48, alpha: 1),
          textMuted: #colorLiteral(red: 78, green: 120, blue: 112, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 4 ↴ 4,
          shadowRadius: 8,
          shadowOpacity: 0.28,
          noiseOpacity: 0.04,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 6 ↴ 6,
          windowShadowOpacity: 0.33,
          windowRadius: 18,
          windowBorder: 3
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 0.5019607843, green: 1, blue: 0.7529411765, alpha: 1),#colorLiteral(red: 0.1098039216, green: 0.2039215686, blue: 0.1568627451, alpha: 1),#colorLiteral(red: 0.1568627451, green: 0.3058823529, blue: 0.2274509804, alpha: 1)
),
            surface: .hierarchy(#colorLiteral(red: 0.5019607843, green: 1, blue: 0.7529411765, alpha: 1),#colorLiteral(red: 0.1098039216, green: 0.2039215686, blue: 0.1568627451, alpha: 1),#colorLiteral(red: 0.1568627451, green: 0.3058823529, blue: 0.2274509804, alpha: 1)),
          accent: .plasmaBlue,
          typography: .highContrast,
          textPrimary: #colorLiteral(red: 225, green: 235, blue: 255, alpha: 1),
          textMuted: #colorLiteral(red: 129, green: 147, blue: 197, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 0,
          shadowOpacity: 0.4,
          noiseOpacity: 0.14,
          windowButtonSize: 18 ↴ 18,
          windowShadowOffset: 8 ↴ 8,
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
          accent: .hierarchy(#colorLiteral(red: 1, green: 0.3215686275, blue: 0.3215686275, alpha: 1),#colorLiteral(red: 0.862745098, green: 0.1490196078, blue: 0.1490196078, alpha: 1),#colorLiteral(red: 0.7254901961, green: 0.1098039216, blue: 0.1098039216, alpha: 1)),
          typography: .blocky,
          textPrimary: #colorLiteral(red: 20, green: 20, blue: 20, alpha: 1),
          textMuted: #colorLiteral(red: 120, green: 120, blue: 120, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 8 ↴ 8,
          shadowRadius: 0,
          shadowOpacity: 0.35,
          noiseOpacity: 0.18
        ),
        dark: Variant(
            background: .hierarchy(#colorLiteral(red: 62, green: 24, blue: 3, alpha: 18),#colorLiteral(red: 28, green: 14, blue: 18, alpha: 1),#colorLiteral(red: 44, green: 18, blue: 26, alpha: 1)),
            surface: .hierarchy(#colorLiteral(red: 79, green: 30, blue: 4, alpha: 12),#colorLiteral(red: 36, green: 16, blue: 20, alpha: 1),#colorLiteral(red: 52, green: 20, blue: 30, alpha: 1)),
          accent: .hierarchy(#colorLiteral(red: 1, green: 0.3215686275, blue: 0.3215686275, alpha: 1),#colorLiteral(red: 0.862745098, green: 0.1490196078, blue: 0.1490196078, alpha: 1),#colorLiteral(red: 0.7254901961, green: 0.1098039216, blue: 0.1098039216, alpha: 1)),
          typography: .blocky,
          textPrimary: #colorLiteral(red: 243, green: 231, blue: 229, alpha: 1),
          textMuted: #colorLiteral(red: 194, green: 150, blue: 148, alpha: 1),
          borderWidth: 3,
          cornerRadius: 0,
          shadowOffset: 6 ↴ 6,
          shadowRadius: 14,
          shadowOpacity: 0.6,
          noiseOpacity: 0.22,
          windowButtonSize: 16 ↴ 16,
          windowShadowOffset: 9 ↴ 9,
          windowShadowOpacity: 0.58,
          windowRadius: 20,
          windowBorder: 3
        )
      )
    }
}

infix operator  ↴ : BitwiseShiftPrecedence

func  ↴ (lhs: some BinaryInteger, rhs: some BinaryInteger) -> CGSize {
    CGSize(width: Double(lhs), height: Double(rhs))
}

