import SwiftUI

/// A reusable surface modifier tailored to the simplified Neo Brutalist look.
public struct NeoBrutalistSurfaceModifier: ViewModifier {
    public enum AccentEdge {
        case top, leading, trailing, bottom

        var alignment: Alignment {
            switch self {
            case .top: return .top
            case .leading: return .leading
            case .trailing: return .trailing
            case .bottom: return .bottom
            }
        }

        var isHorizontal: Bool {
            self == .top || self == .bottom
        }

        var isVertical: Bool {
            self == .leading || self == .trailing
        }
    }

    @Environment(\.neoBrutalistTheme) private var theme

    private let accentEdge: AccentEdge?
    private let isHighlighted: Bool
    private let padding: CGFloat

    public init(accentEdge: AccentEdge?, isHighlighted: Bool, padding: CGFloat) {
        self.accentEdge = accentEdge
        self.isHighlighted = isHighlighted
        self.padding = padding
    }

    public func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(surface)
    }

    private var surface: some View {
        baseShape
            .fill(theme.surface.primary.color)
            .overlay {
                if theme.noiseOpacity > 0 {
                    baseShape
                        .fill(NeoBrutalistNoise.paint())
                        .opacity(theme.noiseOpacity)
                        .blendMode(.overlay)
                }
            }
            .overlay(baseShape.stroke(theme.surface.secondary.color.opacity(0.7), lineWidth: theme.borderWidth))
            .overlay(highlightBorder)
            .overlay(accentBar)
            .compositingGroup()
            .neoBrutalistShadow(
                color: Color.primary.opacity(isHighlighted ? 0.2 : 0.1),
                radius: theme.shadowRadius,
                offset: theme.shadowOffset
            )
    }

    private var highlightBorder: some View {
        baseShape
            .stroke(
                isHighlighted ? theme.accent.highlight.color : theme.surface.highlight.color.opacity(0.8),
                lineWidth: isHighlighted ? theme.borderWidth * 1.4 : theme.borderWidth * 0.6
            )
            .opacity(isHighlighted ? 1 : 0.7)
    }

    private var accentBar: some View {
        Group {
            if let edge = accentEdge {
                Rectangle()
                    .fill(isHighlighted ? theme.accent.highlight.color : theme.accent.primary.color)
                    .frame(
                        width: edge.isVertical ? accentThickness : nil,
                        height: edge.isHorizontal ? accentThickness : nil
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: edge.alignment)
            }
        }
    }

    private var accentThickness: CGFloat {
        max(theme.borderWidth * 3, 8)
    }

    private var baseShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous)
    }
}

public extension View {
    /// Applies the simplified Neo Brutalist surface styling.
    /// - Parameters:
    ///   - accentEdge: Optional edge to emphasize with a solid accent bar.
    ///   - highlighted: Whether the surface should render with a stronger outline and shadow.
    ///   - padding: Automatic padding inside the surface.
    func neoBrutalistSurface(
        accentEdge: NeoBrutalistSurfaceModifier.AccentEdge? = .trailing,
        highlighted: Bool = false,
        padding: CGFloat = 20
    ) -> some View {
        modifier(NeoBrutalistSurfaceModifier(accentEdge: accentEdge, isHighlighted: highlighted, padding: padding))
    }
}
