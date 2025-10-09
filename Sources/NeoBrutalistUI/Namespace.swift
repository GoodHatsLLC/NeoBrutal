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

    /// ready-to-use themes.
    public static var standardThemes: [NeoBrutalistTheme] {
        [
            .bubblegum,
            .daybreakPlaza,
            .nocturneVolt,
            .ultravioletCargo,
            .desert,
            .jungle,
            .breakIdeas
        ]
    }


    private static let noiseImage: Image = {
        let dimension = 128
        let pixelCount = dimension * dimension
        var pixels = [UInt8](repeating: 0, count: pixelCount)

        for index in 0..<pixelCount {
            pixels[index] = UInt8.random(in: 0...255)
        }

        let data = Data(pixels)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bytesPerRow = dimension
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        guard let provider = CGDataProvider(data: data as CFData),
              let cgImage = CGImage(
                  width: dimension,
                  height: dimension,
                  bitsPerComponent: 8,
                  bitsPerPixel: 8,
                  bytesPerRow: bytesPerRow,
                  space: colorSpace,
                  bitmapInfo: bitmapInfo,
                  provider: provider,
                  decode: nil,
                  shouldInterpolate: false,
                  intent: .defaultIntent
              ) else {
            return Image(systemName: "square.fill")
        }

        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }()

    public static func noise(scale: CGFloat = 1) -> ImagePaint {
        ImagePaint(image: noiseImage, scale: scale)
    }
}
