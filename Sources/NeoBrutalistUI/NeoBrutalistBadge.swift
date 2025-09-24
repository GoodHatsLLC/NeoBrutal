import SwiftUI

/// A pill-like label useful for filters and metadata chips.
public struct NeoBrutalistBadge: View {
    public enum IconPlacement { case leading, trailing, none }

    private let text: String
    private let icon: Image?
    private let placement: IconPlacement
    private let isActive: Bool

    @Environment(\.neoBrutalistTheme) private var theme

    public init(_ text: String, icon: Image? = nil, placement: IconPlacement = .leading, isActive: Bool = false) {
        self.text = text
        self.icon = icon
        self.placement = placement
        self.isActive = isActive
    }

    public var body: some View {
        HStack(spacing: 8) {
            if placement == .leading, let icon {
                iconView(icon)
            }

            Text(text.uppercased())
                .font(theme.typography.monoFont)
                .foregroundColor(textColor)
                .neoKerning(1.3)

            if placement == .trailing, let icon {
                iconView(icon)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(background)
    }

    private var background: some View {
        RoundedRectangle(cornerRadius: theme.cornerRadius * 0.6, style: .continuous)
            .fill(isActive ? theme.accent.primary.color : theme.surface.primary.color)
            .overlay(
                RoundedRectangle(cornerRadius: theme.cornerRadius * 0.6, style: .continuous)
                    .stroke(borderColor, lineWidth: theme.borderWidth * 0.6)
            )
    }

    private func iconView(_ icon: Image) -> some View {
        icon
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(textColor)
    }

    private var textColor: Color {
        isActive ? Color.white : theme.textPrimary.color
    }

    private var borderColor: Color {
        isActive ? theme.accent.highlight.color : theme.surface.highlight.color.opacity(0.7)
    }
}
