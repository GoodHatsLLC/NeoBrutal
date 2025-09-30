import SwiftUI

/// A bold, tactile button style inspired by Neo Brutalism.
public struct NeoBrutalistButtonStyle: ButtonStyle {
    public enum Size {
        case compact
        case regular
        case prominent

        var padding: EdgeInsets {
            switch self {
            case .compact: return EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            case .regular: return EdgeInsets(top: 22, leading: 22, bottom: 22, trailing: 22)
            case .prominent: return EdgeInsets(top: 18, leading: 28, bottom: 18, trailing: 28)
            }
        }
    }

    @Environment(\.neoBrutalistTheme) private var theme

    private let size: Size
    private let displayShadow: Bool

    public init(size: Size = .regular, displayShadow: Bool = true) {
        self.size = size
        self.displayShadow = displayShadow
    }

    public func makeBody(configuration: Configuration) -> some View {
        let pressOffset = configuration.isPressed ? theme.shadowOffset : .zero

        configuration.label
            .font(theme.typography.bodyFont)
            .foregroundColor(theme.textPrimary.color)
            .padding(size.padding)
            .background(background(isPressed: configuration.isPressed))
            .offset(x: pressOffset.width, y: pressOffset.height)
//            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.7), value: configuration.isPressed)
    }

    private func background(isPressed: Bool) -> some View {
        let fill = isPressed ? theme.accent.primary.color: theme.surface.primary.color
        let border = isPressed ? theme.accent.highlight.color : theme.accent.primary.color
        let shadowColor = Color.primary.opacity(theme.shadowOpacity)

        return baseShape
            .fill(fill)
            .overlay(baseShape.stroke(border, lineWidth: theme.borderWidth))
            .overlay(baseShape.stroke(theme.surface.highlight.color.opacity(0.6), lineWidth: theme.borderWidth))
            .neoBrutalistShadow(
                color: shadowColor,
                radius: theme.shadowRadius,
                offset: theme.shadowOffset,
                isEnabled: !isPressed && displayShadow
            )
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
