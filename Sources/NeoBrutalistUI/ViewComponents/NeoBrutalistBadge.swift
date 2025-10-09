import SwiftUI

/// A pill-like label useful for filters and metadata chips.
public struct NeoBrutalistBadge: View {
    public enum IconPlacement { case leading, trailing, none }

    private let text: String
    private let icon: Image?
    private let placement: IconPlacement
    private let isActive: Bool

    @Environment(\.nb) private var nbTheme

    public init(_ text: String, icon: Image? = nil, placement: IconPlacement = .leading, isActive: Bool = false) {
        self.text = text
        self.icon = icon
        self.placement = placement
        self.isActive = isActive
    }

    public var body: some View {
        HStack(spacing: 8) {
            if placement == .leading, let icon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(isActive ? AnyShapeStyle(.white) : AnyShapeStyle(.nb.textPrimary))
            }

            Text(text.uppercased())
                .font(nbTheme.typography.monoFont)
                .foregroundStyle(isActive ? AnyShapeStyle(.white) : AnyShapeStyle(.nb.textPrimary))
                .kerning(1.3)

            if placement == .trailing, let icon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(isActive ? AnyShapeStyle(.white) : AnyShapeStyle(.nb.textPrimary))
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(background)
    }

    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.6, style: .continuous)
            .fill(isActive ? Color.nb.accent.primary : Color.nb.surface.primary)
            .overlay(
                Group {
                    if isActive {
                        RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.6, style: .continuous)
                            .stroke(.nb.accent.highlight, lineWidth: nbTheme.borderWidth * 0.6)
                    } else {
                        RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.6, style: .continuous)
                            .stroke(.nb.surface.highlight.opacity(0.7), lineWidth: nbTheme.borderWidth * 0.6)
                    }
                }
            )
    }
}
