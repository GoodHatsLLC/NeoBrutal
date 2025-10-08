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
    @Environment(\.colorScheme) private var colorScheme

    private var themeVariant: NeoBrutalistTheme.Variant {
        theme.variant(for: colorScheme)
    }

    private let size: Size
    private let displayShadow: Bool
    @Environment(\.isEnabled) var isEnabled

    public init(size: Size = .regular, displayShadow: Bool = true) {
        self.size = size
        self.displayShadow = displayShadow
    }

    public func makeBody(configuration: Configuration) -> some View {
        let pressOffset = configuration.isPressed ? themeVariant.shadowOffset : .zero

        configuration.label
            .font(themeVariant.typography.bodyFont)
            .foregroundStyle(.nb.textPrimary)
            .padding(size.padding)
            .background(background(isPressed: configuration.isPressed))
            .compositingGroup()
            .offset(x: pressOffset.width, y: pressOffset.height)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.7), value: configuration.isPressed)
    }

    @ViewBuilder
    private func background(isPressed: Bool) -> some View {
        let shadowColor = Color.primary.opacity(themeVariant.shadowOpacity)

        if isEnabled {
                baseShape
                    .fill(.nb.surface.primary)
                    .overlay(baseShape.stroke(.nb.accent.primary, lineWidth: themeVariant.borderWidth))
                    .overlay(baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: themeVariant.borderWidth))
                    .compositingGroup()
                    .neoBrutalistShadow(
                        color: shadowColor,
                        radius: themeVariant.shadowRadius,
                        offset: themeVariant.shadowOffset,
                        isEnabled: !isPressed && displayShadow
                    )
        } else {
            // For disabled state, we need to compute a mixed color
            let disabledFill = themeVariant.surface.secondary.color.mix(with: .gray, by: 0.1)
            baseShape
                .fill(disabledFill)
                .overlay(baseShape.stroke(.primary, lineWidth: themeVariant.borderWidth))
                .overlay(baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: themeVariant.borderWidth))
                .compositingGroup()
                .neoBrutalistShadow(
                    color: shadowColor,
                    radius: themeVariant.shadowRadius,
                    offset: themeVariant.shadowOffset,
                    isEnabled: !isPressed && displayShadow
                )
        }
    }

    private var baseShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: themeVariant.cornerRadius, style: .continuous)
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
