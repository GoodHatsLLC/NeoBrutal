import SwiftUI

/// A bold, tactile button style inspired by Neo Brutalism.
public struct NeoBrutalistButtonStyle: ButtonStyle {
    public enum Size {
        case compact
        case regular
        case prominent

        var padding: EdgeInsets {
            switch self {
            case .compact: return EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            case .regular: return EdgeInsets(top: 22, leading: 22, bottom: 22, trailing: 22)
            case .prominent: return EdgeInsets(top: 18, leading: 28, bottom: 18, trailing: 28)
            }
        }
    }

    @Environment(\.neoBrutalistTheme) private var theme

    private let size: Size
    private let displayShadow: Bool
    @Environment(\.isEnabled) var isEnabled

    public init(size: Size = .regular, displayShadow: Bool = true) {
        self.size = size
        self.displayShadow = displayShadow
    }

    public func makeBody(configuration: Configuration) -> some View {
        let pressOffset = configuration.isPressed ? theme.shadowOffset : .zero

        configuration.label
            .font(theme.typography.bodyFont)
            .foregroundStyle(.nb.textPrimary)
            .padding(size.padding)
            .background(background(isPressed: configuration.isPressed))
            .offset(x: pressOffset.width, y: pressOffset.height)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.7), value: configuration.isPressed)
    }

    @ViewBuilder
    private func background(isPressed: Bool) -> some View {
        let shadowColor = Color.primary.opacity(theme.shadowOpacity)

        if isEnabled {
            if isPressed {
                baseShape
                    .fill(.nb.accent.primary)
                    .overlay(baseShape.stroke(.nb.accent.highlight, lineWidth: theme.borderWidth))
                    .overlay(baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: theme.borderWidth))
                    .compositingGroup()
                    .neoBrutalistShadow(
                        color: shadowColor,
                        radius: theme.shadowRadius,
                        offset: theme.shadowOffset,
                        isEnabled: !isPressed && displayShadow
                    )
            } else {
                baseShape
                    .fill(.nb.surface.primary)
                    .overlay(baseShape.stroke(.nb.accent.primary, lineWidth: theme.borderWidth))
                    .overlay(baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: theme.borderWidth))
                    .compositingGroup()
                    .neoBrutalistShadow(
                        color: shadowColor,
                        radius: theme.shadowRadius,
                        offset: theme.shadowOffset,
                        isEnabled: !isPressed && displayShadow
                    )
            }
        } else {
            // For disabled state, we need to compute a mixed color
            let disabledFill = theme.surface.secondary.color.mix(with: .gray, by: 0.1)
            baseShape
                .fill(disabledFill)
                .overlay(baseShape.stroke(.primary, lineWidth: theme.borderWidth))
                .overlay(baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: theme.borderWidth))
                .compositingGroup()
                .neoBrutalistShadow(
                    color: shadowColor,
                    radius: theme.shadowRadius,
                    offset: theme.shadowOffset,
                    isEnabled: !isPressed && displayShadow
                )
        }
    }

    private var baseShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous)
    }
}

public extension ButtonStyle where Self == NeoBrutalistButtonStyle {
    static func neoBrutalist(size: NeoBrutalistButtonStyle.Size = .regular, displayShadow: Bool = true) -> NeoBrutalistButtonStyle {
        NeoBrutalistButtonStyle(size: size, displayShadow: displayShadow)
    }
}

/// Convenience view that wraps a standard `Button` applying the Neo Brutalist style.
public struct NeoBrutalistButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    private let size: NeoBrutalistButtonStyle.Size
    private let displayShadow: Bool

    public init(size: NeoBrutalistButtonStyle.Size = .regular, displayShadow: Bool = true, action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
        self.size = size
        self.displayShadow = displayShadow
    }

    public var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(.neoBrutalist(size: size, displayShadow: displayShadow))
    }
}
