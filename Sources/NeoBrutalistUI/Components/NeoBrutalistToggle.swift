import SwiftUI

/// A chunky toggle control that matches the Neo Brutalist aesthetic.
public struct NeoBrutalistToggleStyle: ToggleStyle {
    public enum Size {
        case compact
        case regular
        case large

        var trackSize: CGSize {
            switch self {
            case .compact: return CGSize(width: 56, height: 28)
            case .regular: return CGSize(width: 68, height: 34)
            case .large: return CGSize(width: 86, height: 42)
            }
        }
    }

    @Environment(\.neoBrutalistTheme) private var theme

    private let size: Size

    public init(size: Size = .regular) {
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 16) {
            configuration.label
                .font(theme.typography.bodyFont)
                .foregroundStyle(.nb.textPrimary)
            Spacer(minLength: 0)
            toggle(configuration: configuration)
        }
    }

    private func toggle(configuration: Configuration) -> some View {
        let trackSize = size.trackSize
        let knobSide = trackSize.height - 10
        let trackCornerRadius: CGFloat = 8

        return ZStack(alignment: configuration.isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: trackCornerRadius, style: .continuous)
                .fill(configuration.isOn ? Color.nb.accent.primary.opacity(0.18) : Color.nb.surface.secondary.opacity(0.6))
                .overlay(
                    Group {
                        if configuration.isOn {
                            RoundedRectangle(cornerRadius: trackCornerRadius, style: .continuous)
                                .stroke(.nb.accent.primary, lineWidth: theme.borderWidth)
                        } else {
                            RoundedRectangle(cornerRadius: trackCornerRadius, style: .continuous)
                                .stroke(.nb.surface.highlight.opacity(0.7), lineWidth: theme.borderWidth)
                        }
                    }
                )
                .frame(width: trackSize.width, height: trackSize.height)

            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(configuration.isOn ? Color.nb.accent.primary : Color.nb.surface.primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .frame(width: knobSide, height: knobSide)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.clear)
                )
                .padding(5)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                configuration.isOn.toggle()
            }
        }
        .padding(.horizontal, theme.borderWidth)
    }
}

public extension ToggleStyle where Self == NeoBrutalistToggleStyle {
    static func neoBrutalist(size: NeoBrutalistToggleStyle.Size = .regular) -> NeoBrutalistToggleStyle {
        NeoBrutalistToggleStyle(size: size)
    }
}
