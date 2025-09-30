import SwiftUI
import CoreGraphics
import Foundation

extension View {
    @ViewBuilder
    func neoKerning(_ value: CGFloat) -> some View {
        #if os(macOS)
        if #available(macOS 13.0, *) {
            kerning(value)
        } else {
            self
        }
        #else
        kerning(value)
        #endif
    }

    /// Applies a hard-edged shadow when the theme requests a zero-radius drop shadow.
    func neoBrutalistShadow(color: Color, radius: CGFloat, offset: CGSize, clip: Axis? = nil, isEnabled: Bool = true) -> some View {
        modifier(
            NeoBrutalistShadowModifier(
                color: color,
                radius: radius,
                offset: offset,
                clip: clip,
                isEnabled: isEnabled
            )
        )
    }
}

private struct NeoBrutalistShadowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    let offset: CGSize
    let clip: Axis?
    let isEnabled: Bool
    var modOffset: CGSize { isEnabled ? offset : .zero }

    @ViewBuilder
    func body(content: Content) -> some View {
            if radius <= 0 {
                content
                    .background {
                        color
                            .offset(x: modOffset.width, y: modOffset.height)
                    }
                    .padding(.bottom, max(clip == .vertical ? 0 :  offset.height, 0))
                    .padding(.top, max(clip == .vertical ? 0 : offset.height, 0))
                    .padding(.trailing, max(clip == .horizontal ? 0 : offset.width, 0))
                    .padding(.leading, max(clip == .horizontal ? 0 : offset.width, 0))
                    .clipped()
            } else {
                content.shadow(
                    color: color,
                    radius: radius,
                    x: modOffset.width,
                    y: modOffset.height
                )
                .padding(.bottom, max(clip == .vertical ? 0 :  offset.height, 0))
                .padding(.top, max(clip == .vertical ? 0 : offset.height, 0))
                .padding(.trailing, max(clip == .horizontal ? 0 : offset.width, 0))
                .padding(.leading, max(clip == .horizontal ? 0 : offset.width, 0))

            }
    }
}

enum NeoBrutalistNoise {
    static let image: Image = {
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

    static func paint(scale: CGFloat = 1) -> ImagePaint {
        ImagePaint(image: image, scale: scale)
    }
}
