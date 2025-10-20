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
    public static let baseAccent: Palette = .hierarchy(#colorLiteral(red: 0.35, green: 0.70, blue: 0.95, alpha: 1),#colorLiteral(red: 0.50, green: 0.85, blue: 1.0, alpha: 1),#colorLiteral(red: 0.70, green: 0.92, blue: 1.0, alpha: 1))
}

extension NeoBrutalTheme {
  public static var primaryPlaytime: NeoBrutalTheme {
     NeoBrutalTheme(
       name: "primaryPlaytime",
       light: Variant(
         background: .paper,
         surface: .paper,
         accent: .hierarchy(#colorLiteral(red: 0, green: 0.6823529412, blue: 0.9333333333, alpha: 1),#colorLiteral(red: 1, green: 0.3607843137, blue: 0.5411764706, alpha: 1),#colorLiteral(red: 0.9960784314, green: 0.8941176471, blue: 0.2509803922, alpha: 1)),
         typography: .blocky,
         textPrimary: #colorLiteral(red: 0.0705882353, green: 0.0705882353, blue: 0.0705882353, alpha: 1),
         textMuted: #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1),
         borderWidth: 2,
         shadowOffset: CGSize(width: 6, height: 6),
         shadowRadius: 0,
         noiseOpacity: 0
       ),
       dark: Variant(
          background: .hierarchy(#colorLiteral(red: 0.1568627451, green: 0.1764705882, blue: 0.2392156863, alpha: 1),#colorLiteral(red: 0.0784313725, green:0.0862745098, blue: 0.1176470588, alpha: 1),#colorLiteral(red: 0.1137254902, green: 0.1294117647, blue: 0.1725490196, alpha: 1)),
          surface: .hierarchy(#colorLiteral(red: 0.2392156863, green: 0.2666666667, blue: 0.3529411765, alpha: 1),#colorLiteral(red: 0.1019607843, green: 0.1176470588, blue: 0.1647058824, alpha: 1),#colorLiteral(red: 0.1529411765, green: 0.1725490196, blue: 0.231372549, alpha: 1)),
          accent: .hierarchy(#colorLiteral(red: 0.2228515625, green: 0.7422794118, blue: 0.9333333333, alpha: 1),#colorLiteral(red: 1, green: 0.437056108, blue: 0.5959237094, alpha: 1),#colorLiteral(red: 0.9960784314, green: 0.9117194555, blue: 0.379608992, alpha: 1)),
         typography: .blocky,
         textPrimary: #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9725490196, alpha: 1),
         textMuted: #colorLiteral(red: 0.7137254902, green: 0.7294117647, blue: 0.7960784314, alpha: 1),
         borderWidth: 2,
         shadowOffset: CGSize(width: 6, height: 6),
         shadowRadius: 0,
         noiseOpacity: 0.3
       )
     )
   }
  public static var bubblegum: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "bubblegum",
         light: Variant(
           background: .paper,
           surface: .paper,
           accent: .hierarchy(#colorLiteral(red: 0.3725490196, green: 0.5529411765, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.4666666667, blue: 0.6588235294, alpha: 1),#colorLiteral(red: 1, green: 0.6666666667, blue: 0.7843137255, alpha: 1)),
           typography: .blocky,
           textPrimary: #colorLiteral(red: 0.0705882353, green: 0.0705882353, blue: 0.0705882353, alpha: 1),
           textMuted: #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1),
           borderWidth: 2,
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
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 0,
           noiseOpacity: 0.3
         )
       )
     }

    // MARK: - Midnight Citrus
    // Dark, sophisticated theme with vibrant citrus accents
    public static var midnightCitrus: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "midnightCitrus",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.2, green: 0.22, blue: 0.26, alpha: 1),    // Charcoal blue
             #colorLiteral(red: 0.14, green: 0.16, blue: 0.20, alpha: 1),   // Dark navy
             #colorLiteral(red: 0.17, green: 0.19, blue: 0.23, alpha: 1)    // Mid navy
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.28, green: 0.31, blue: 0.36, alpha: 1),   // Slate
             #colorLiteral(red: 0.22, green: 0.25, blue: 0.30, alpha: 1),   // Dark slate
             #colorLiteral(red: 0.25, green: 0.28, blue: 0.33, alpha: 1)    // Mid slate
           ),
           accent: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.65, blue: 0.0, alpha: 1),     // Vibrant orange
             #colorLiteral(red: 0.70, green: 0.95, blue: 0.30, alpha: 1),   // Electric lime
             #colorLiteral(red: 1.0, green: 0.85, blue: 0.30, alpha: 1)     // Bright yellow
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 0.98, green: 0.98, blue: 0.99, alpha: 1),
           textMuted: #colorLiteral(red: 0.65, green: 0.68, blue: 0.73, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 4, height: 4),
           shadowRadius: 8,
           shadowOpacity: 0.6,
           noiseOpacity: 0.15
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.10, green: 0.11, blue: 0.14, alpha: 1),
             #colorLiteral(red: 0.06, green: 0.07, blue: 0.10, alpha: 1),
             #colorLiteral(red: 0.08, green: 0.09, blue: 0.12, alpha: 1)
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.18, green: 0.20, blue: 0.24, alpha: 1),
             #colorLiteral(red: 0.12, green: 0.14, blue: 0.18, alpha: 1),
             #colorLiteral(red: 0.15, green: 0.17, blue: 0.21, alpha: 1)
           ),
           accent: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.70, blue: 0.10, alpha: 1),
             #colorLiteral(red: 0.75, green: 1.0, blue: 0.35, alpha: 1),
             #colorLiteral(red: 1.0, green: 0.90, blue: 0.35, alpha: 1)
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 0.99, green: 0.99, blue: 1.0, alpha: 1),
           textMuted: #colorLiteral(red: 0.60, green: 0.63, blue: 0.68, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 5, height: 5),
           shadowRadius: 12,
           shadowOpacity: 0.7,
           noiseOpacity: 0.25
         )
       )
     }

    // MARK: - Cherry Blossom
    // Elegant theme with soft pinks and deep burgundy
    public static var cherryBlossom: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "cherryBlossom",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.98, green: 0.93, blue: 0.94, alpha: 1),   // Soft pink
             #colorLiteral(red: 1.0, green: 0.96, blue: 0.97, alpha: 1),    // Pale pink
             #colorLiteral(red: 0.99, green: 0.95, blue: 0.96, alpha: 1)    // Light blush
           ),
           surface: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.97, blue: 0.98, alpha: 1),    // Cream pink
             #colorLiteral(red: 0.96, green: 0.90, blue: 0.92, alpha: 1),   // Dusty rose
             #colorLiteral(red: 0.98, green: 0.94, blue: 0.95, alpha: 1)    // Blush white
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.70, green: 0.13, blue: 0.29, alpha: 1),   // Deep burgundy
             #colorLiteral(red: 0.95, green: 0.40, blue: 0.55, alpha: 1),   // Rose
             #colorLiteral(red: 0.98, green: 0.65, blue: 0.72, alpha: 1)    // Coral pink
           ),
           typography: .playful,
           textPrimary: #colorLiteral(red: 0.25, green: 0.08, blue: 0.14, alpha: 1),
           textMuted: #colorLiteral(red: 0.55, green: 0.45, blue: 0.48, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 8, height: 8),
           shadowRadius: 0,
           shadowOpacity: 0.3,
           noiseOpacity: 0.08
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.20, green: 0.12, blue: 0.15, alpha: 1),
             #colorLiteral(red: 0.14, green: 0.08, blue: 0.11, alpha: 1),
             #colorLiteral(red: 0.17, green: 0.10, blue: 0.13, alpha: 1)
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.28, green: 0.18, blue: 0.22, alpha: 1),
             #colorLiteral(red: 0.22, green: 0.14, blue: 0.17, alpha: 1),
             #colorLiteral(red: 0.25, green: 0.16, blue: 0.20, alpha: 1)
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.85, green: 0.25, blue: 0.42, alpha: 1),
             #colorLiteral(red: 1.0, green: 0.50, blue: 0.65, alpha: 1),
             #colorLiteral(red: 1.0, green: 0.72, blue: 0.80, alpha: 1)
           ),
           typography: .playful,
           textPrimary: #colorLiteral(red: 0.98, green: 0.90, blue: 0.93, alpha: 1),
           textMuted: #colorLiteral(red: 0.70, green: 0.60, blue: 0.63, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 8, height: 8),
           shadowRadius: 0,
           shadowOpacity: 0.4,
           noiseOpacity: 0.2
         )
       )
     }

    // MARK: - Cyber Punk
    // High-tech theme with neon purples and cyans
    public static var cyberPunk: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "cyberPunk",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.95, green: 0.94, blue: 0.98, alpha: 1),   // Light lavender
             #colorLiteral(red: 0.98, green: 0.97, blue: 1.0, alpha: 1),    // Off white
             #colorLiteral(red: 0.96, green: 0.95, blue: 0.99, alpha: 1)    // Pale purple
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.92, green: 0.90, blue: 0.97, alpha: 1),   // Soft purple
             #colorLiteral(red: 0.88, green: 0.93, blue: 0.98, alpha: 1),   // Light cyan
             #colorLiteral(red: 0.90, green: 0.92, blue: 0.98, alpha: 1)    // Periwinkle
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.58, green: 0.20, blue: 0.90, alpha: 1),   // Electric purple
             #colorLiteral(red: 0.20, green: 0.80, blue: 0.95, alpha: 1),   // Neon cyan
             #colorLiteral(red: 0.95, green: 0.30, blue: 0.85, alpha: 1)    // Hot magenta
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 0.12, green: 0.10, blue: 0.18, alpha: 1),
           textMuted: #colorLiteral(red: 0.50, green: 0.48, blue: 0.58, alpha: 1),
           borderWidth: 2,
           shadowOffset: CGSize(width: 0, height: 4),
           shadowRadius: 16,
           shadowOpacity: 0.5,
           noiseOpacity: 0.05
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.08, green: 0.07, blue: 0.12, alpha: 1),
             #colorLiteral(red: 0.05, green: 0.04, blue: 0.08, alpha: 1),
             #colorLiteral(red: 0.06, green: 0.06, blue: 0.10, alpha: 1)
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.14, green: 0.12, blue: 0.20, alpha: 1),
             #colorLiteral(red: 0.10, green: 0.15, blue: 0.22, alpha: 1),
             #colorLiteral(red: 0.12, green: 0.14, blue: 0.21, alpha: 1)
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.75, green: 0.30, blue: 1.0, alpha: 1),
             #colorLiteral(red: 0.30, green: 0.95, blue: 1.0, alpha: 1),
             #colorLiteral(red: 1.0, green: 0.40, blue: 0.95, alpha: 1)
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 0.95, green: 0.94, blue: 1.0, alpha: 1),
           textMuted: #colorLiteral(red: 0.65, green: 0.63, blue: 0.75, alpha: 1),
           borderWidth: 2,
           shadowOffset: CGSize(width: 0, height: 6),
           shadowRadius: 20,
           shadowOpacity: 0.7,
           noiseOpacity: 0.18
         )
       )
     }

    // MARK: - Desert Storm
    // Warm, earthy theme with terracotta and sand tones
    public static var desertStorm: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "desertStorm",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.93, green: 0.88, blue: 0.78, alpha: 1),   // Warm sand
             #colorLiteral(red: 0.96, green: 0.92, blue: 0.84, alpha: 1),   // Light sand
             #colorLiteral(red: 0.95, green: 0.90, blue: 0.81, alpha: 1)    // Cream sand
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.98, green: 0.95, blue: 0.90, alpha: 1),   // Pale cream
             #colorLiteral(red: 0.90, green: 0.84, blue: 0.72, alpha: 1),   // Tan
             #colorLiteral(red: 0.94, green: 0.90, blue: 0.81, alpha: 1)    // Light tan
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.78, green: 0.35, blue: 0.22, alpha: 1),   // Terracotta
             #colorLiteral(red: 0.85, green: 0.55, blue: 0.25, alpha: 1),   // Burnt orange
             #colorLiteral(red: 0.90, green: 0.72, blue: 0.40, alpha: 1)    // Golden ochre
           ),
           typography: .default,
           textPrimary: #colorLiteral(red: 0.22, green: 0.18, blue: 0.14, alpha: 1),
           textMuted: #colorLiteral(red: 0.52, green: 0.48, blue: 0.42, alpha: 1),
           borderWidth: 2.5,
           shadowOffset: CGSize(width: 5, height: 5),
           shadowRadius: 2,
           shadowOpacity: 0.35,
           noiseOpacity: 0.35
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.18, green: 0.15, blue: 0.12, alpha: 1),
             #colorLiteral(red: 0.12, green: 0.10, blue: 0.08, alpha: 1),
             #colorLiteral(red: 0.15, green: 0.13, blue: 0.10, alpha: 1)
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.26, green: 0.22, blue: 0.18, alpha: 1),
             #colorLiteral(red: 0.20, green: 0.17, blue: 0.14, alpha: 1),
             #colorLiteral(red: 0.23, green: 0.20, blue: 0.16, alpha: 1)
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.92, green: 0.48, blue: 0.32, alpha: 1),
             #colorLiteral(red: 0.95, green: 0.68, blue: 0.38, alpha: 1),
             #colorLiteral(red: 0.98, green: 0.82, blue: 0.52, alpha: 1)
           ),
           typography: .default,
           textPrimary: #colorLiteral(red: 0.94, green: 0.90, blue: 0.84, alpha: 1),
           textMuted: #colorLiteral(red: 0.68, green: 0.64, blue: 0.58, alpha: 1),
           borderWidth: 2.5,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 3,
           shadowOpacity: 0.45,
           noiseOpacity: 0.42
         )
       )
     }

    // MARK: - Arctic Frost
    // Cool, crisp theme with icy blues and pristine whites
    public static var arcticFrost: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "arcticFrost",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.96, green: 0.98, blue: 1.0, alpha: 1),    // Ice white
             #colorLiteral(red: 0.98, green: 0.99, blue: 1.0, alpha: 1),    // Pure white
             #colorLiteral(red: 0.97, green: 0.99, blue: 1.0, alpha: 1)     // Snow white
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.93, green: 0.96, blue: 1.0, alpha: 1),    // Frost blue
             #colorLiteral(red: 0.90, green: 0.95, blue: 0.98, alpha: 1),   // Glacier
             #colorLiteral(red: 0.92, green: 0.96, blue: 0.99, alpha: 1)    // Pale ice
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.20, green: 0.55, blue: 0.85, alpha: 1),   // Arctic blue
             #colorLiteral(red: 0.35, green: 0.75, blue: 0.92, alpha: 1),   // Sky blue
             #colorLiteral(red: 0.60, green: 0.88, blue: 0.98, alpha: 1)    // Ice blue
           ),
           typography: .blocky,
           textPrimary: #colorLiteral(red: 0.10, green: 0.15, blue: 0.25, alpha: 1),
           textMuted: #colorLiteral(red: 0.48, green: 0.55, blue: 0.65, alpha: 1),
           borderWidth: 2,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 0,
           shadowOpacity: 0.25,
           noiseOpacity: 0.03
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.12, green: 0.16, blue: 0.22, alpha: 1),
             #colorLiteral(red: 0.08, green: 0.11, blue: 0.16, alpha: 1),
             #colorLiteral(red: 0.10, green: 0.14, blue: 0.19, alpha: 1)
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.18, green: 0.24, blue: 0.32, alpha: 1),
             #colorLiteral(red: 0.14, green: 0.19, blue: 0.26, alpha: 1),
             #colorLiteral(red: 0.16, green: 0.22, blue: 0.29, alpha: 1)
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.35, green: 0.70, blue: 0.95, alpha: 1),
             #colorLiteral(red: 0.50, green: 0.85, blue: 1.0, alpha: 1),
             #colorLiteral(red: 0.70, green: 0.92, blue: 1.0, alpha: 1)
           ),
           typography: .blocky,
           textPrimary: #colorLiteral(red: 0.92, green: 0.96, blue: 1.0, alpha: 1),
           textMuted: #colorLiteral(red: 0.65, green: 0.72, blue: 0.82, alpha: 1),
           borderWidth: 2,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 0,
           shadowOpacity: 0.35,
           noiseOpacity: 0.12
         )
       )
     }

    // MARK: - Ocean Depths
    // Nautical theme with deep teals, ocean blues, and vibrant coral accents
    public static var oceanDepths: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "oceanDepths",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.88, green: 0.95, blue: 0.96, alpha: 1),   // Light seafoam
             #colorLiteral(red: 0.92, green: 0.97, blue: 0.98, alpha: 1),   // Pale aqua
             #colorLiteral(red: 0.90, green: 0.96, blue: 0.97, alpha: 1)    // Soft mint
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.95, green: 0.98, blue: 0.99, alpha: 1),   // Pearl white
             #colorLiteral(red: 0.85, green: 0.93, blue: 0.94, alpha: 1),   // Aqua mist
             #colorLiteral(red: 0.90, green: 0.96, blue: 0.97, alpha: 1)    // Sea spray
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.12, green: 0.52, blue: 0.58, alpha: 1),   // Deep teal
             #colorLiteral(red: 0.95, green: 0.45, blue: 0.38, alpha: 1),   // Coral
             #colorLiteral(red: 0.25, green: 0.68, blue: 0.78, alpha: 1)    // Turquoise
           ),
           typography: .playful,
           textPrimary: #colorLiteral(red: 0.08, green: 0.28, blue: 0.32, alpha: 1),
           textMuted: #colorLiteral(red: 0.42, green: 0.56, blue: 0.60, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 5, height: 5),
           shadowRadius: 4,
           shadowOpacity: 0.35,
           noiseOpacity: 0.1
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.08, green: 0.16, blue: 0.18, alpha: 1),   // Deep ocean
             #colorLiteral(red: 0.05, green: 0.11, blue: 0.13, alpha: 1),   // Midnight water
             #colorLiteral(red: 0.06, green: 0.14, blue: 0.16, alpha: 1)    // Dark depths
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.12, green: 0.24, blue: 0.27, alpha: 1),   // Deep sea
             #colorLiteral(red: 0.09, green: 0.18, blue: 0.21, alpha: 1),   // Abyss
             #colorLiteral(red: 0.10, green: 0.21, blue: 0.24, alpha: 1)    // Ocean floor
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.20, green: 0.75, blue: 0.82, alpha: 1),   // Bright teal
             #colorLiteral(red: 1.0, green: 0.58, blue: 0.52, alpha: 1),    // Bright coral
             #colorLiteral(red: 0.38, green: 0.88, blue: 0.95, alpha: 1)    // Electric turquoise
           ),
           typography: .playful,
           textPrimary: #colorLiteral(red: 0.92, green: 0.98, blue: 0.99, alpha: 1),
           textMuted: #colorLiteral(red: 0.62, green: 0.76, blue: 0.80, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 6, height: 6),
           shadowRadius: 6,
           shadowOpacity: 0.5,
           noiseOpacity: 0.22
         )
       )
     }

    // MARK: - Sunset Boulevard
    // Vibrant sunset theme with warm oranges, purples, and pink highlights
    public static var sunsetBoulevard: NeoBrutalTheme {
       NeoBrutalTheme(
         name: "sunsetBoulevard",
         light: Variant(
           background: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.93, blue: 0.86, alpha: 1),    // Peach cream
             #colorLiteral(red: 1.0, green: 0.96, blue: 0.92, alpha: 1),    // Soft peach
             #colorLiteral(red: 1.0, green: 0.95, blue: 0.89, alpha: 1)     // Warm cream
           ),
           surface: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.97, blue: 0.94, alpha: 1),    // Light peach
             #colorLiteral(red: 0.98, green: 0.91, blue: 0.84, alpha: 1),   // Sand peach
             #colorLiteral(red: 0.99, green: 0.94, blue: 0.89, alpha: 1)    // Pale sunset
           ),
           accent: .hierarchy(
             #colorLiteral(red: 0.95, green: 0.42, blue: 0.28, alpha: 1),   // Sunset orange
             #colorLiteral(red: 0.65, green: 0.32, blue: 0.78, alpha: 1),   // Royal purple
             #colorLiteral(red: 1.0, green: 0.55, blue: 0.72, alpha: 1)     // Hot pink
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 0.28, green: 0.12, blue: 0.22, alpha: 1),
           textMuted: #colorLiteral(red: 0.62, green: 0.48, blue: 0.52, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 7, height: 7),
           shadowRadius: 0,
           shadowOpacity: 0.4,
           noiseOpacity: 0.06
         ),
         dark: Variant(
           background: .hierarchy(
             #colorLiteral(red: 0.16, green: 0.10, blue: 0.14, alpha: 1),   // Deep twilight
             #colorLiteral(red: 0.11, green: 0.07, blue: 0.10, alpha: 1),   // Midnight purple
             #colorLiteral(red: 0.14, green: 0.08, blue: 0.12, alpha: 1)    // Dark dusk
           ),
           surface: .hierarchy(
             #colorLiteral(red: 0.24, green: 0.16, blue: 0.20, alpha: 1),   // Dusk purple
             #colorLiteral(red: 0.18, green: 0.12, blue: 0.16, alpha: 1),   // Evening violet
             #colorLiteral(red: 0.21, green: 0.14, blue: 0.18, alpha: 1)    // Twilight
           ),
           accent: .hierarchy(
             #colorLiteral(red: 1.0, green: 0.55, blue: 0.40, alpha: 1),    // Bright sunset
             #colorLiteral(red: 0.82, green: 0.48, blue: 0.95, alpha: 1),   // Vivid purple
             #colorLiteral(red: 1.0, green: 0.68, blue: 0.82, alpha: 1)     // Bright pink
           ),
           typography: .highContrast,
           textPrimary: #colorLiteral(red: 1.0, green: 0.94, blue: 0.92, alpha: 1),
           textMuted: #colorLiteral(red: 0.78, green: 0.68, blue: 0.72, alpha: 1),
           borderWidth: 3,
           shadowOffset: CGSize(width: 8, height: 8),
           shadowRadius: 0,
           shadowOpacity: 0.5,
           noiseOpacity: 0.15
         )
       )
     }
}

infix operator  ↴ : BitwiseShiftPrecedence

private func  ↴ (lhs: some BinaryInteger, rhs: some BinaryInteger) -> CGSize {
    CGSize(width: Double(lhs), height: Double(rhs))
}
