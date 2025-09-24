import SwiftUI

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

    @ViewBuilder
    func body(content: Content) -> some View {
        if isEnabled {
            if radius <= 0 {
                content
                    .background {
                        color
                            .offset(x: offset.width, y: offset.height)
                    }
                    .padding(.bottom, max(clip == .vertical ? 0 :  offset.height, 0))
                    .padding(.top, max(clip == .vertical ? 0 : -offset.height, 0))
                    .padding(.trailing, max(clip == .horizontal ? 0 : offset.width, 0))
                    .padding(.leading, max(clip == .horizontal ? 0 : -offset.width, 0))
                    .clipped()
            } else {
                content.shadow(
                    color: color,
                    radius: radius,
                    x: offset.width,
                    y: offset.height
                )
                .padding(.bottom, max(clip == .vertical ? 0 :  offset.height, 0))
                .padding(.top, max(clip == .vertical ? 0 : -offset.height, 0))
                .padding(.trailing, max(clip == .horizontal ? 0 : offset.width, 0))
                .padding(.leading, max(clip == .horizontal ? 0 : -offset.width, 0))

            }
        } else {
            content
        }
    }
}
