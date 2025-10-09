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

  @Environment(\.nb) private var nbTheme

  private let accentEdge: AccentEdge?
  private let isHighlighted: Bool

  public init(accentEdge: AccentEdge?, isHighlighted: Bool) {
    self.accentEdge = accentEdge
    self.isHighlighted = isHighlighted
  }

  public func body(content: Content) -> some View {
    content
      .background(surface)
      .padding(accentEdge.padding(size: accentThickness))
      .background(
        baseShape
          .fill(isHighlighted ? Color.nb.accent.highlight : Color.nb.accent.primary)
      )
      .compositingGroup()
      .neoBrutalistShadow(
        color: Color.primary.opacity(
          isHighlighted ? min(1, nbTheme.shadowOpacity + 0.2) : nbTheme.shadowOpacity),
        radius: nbTheme.shadowRadius,
        offset: nbTheme.shadowOffset,
        cornerRadius: nbTheme.cornerRadius
      )
  }

  private var surface: some View {
    baseShape
      .fill(.nb.surface.primary)
      .overlay {
        if nbTheme.noiseOpacity > 0 {
          baseShape
            .fill(NeoBrutalist.noise())
            .opacity(nbTheme.noiseOpacity)
            .blendMode(.overlay)
        }
      }
      .overlay(baseShape.stroke(.nb.surface.secondary.opacity(0.7), lineWidth: nbTheme.borderWidth))
      .overlay(highlightBorder)
  }

  @ViewBuilder
  private var highlightBorder: some View {
    if isHighlighted {
      baseShape
        .stroke(.nb.accent.highlight, lineWidth: nbTheme.borderWidth * 1.4)
        .opacity(1)
    } else {
      baseShape
        .stroke(.nb.surface.highlight.opacity(0.8), lineWidth: nbTheme.borderWidth * 0.6)
        .opacity(0.7)
    }
  }

  private var accentThickness: CGFloat {
    max(nbTheme.borderWidth * 3, 8)
  }

  private var baseShape: RoundedRectangle {
    RoundedRectangle(cornerRadius: nbTheme.cornerRadius, style: .continuous)
  }
}

extension View {
  /// Applies the simplified Neo Brutalist surface styling.
  /// - Parameters:
  ///   - accentEdge: Optional edge to emphasize with a solid accent bar.
  ///   - highlighted: Whether the surface should render with a stronger outline and shadow.
  ///   - padding: Automatic padding inside the surface.
  public func neoBrutalistSurface(
    accentEdge: NeoBrutalistSurfaceModifier.AccentEdge? = .trailing,
    highlighted: Bool = false
  ) -> some View {
    modifier(NeoBrutalistSurfaceModifier(accentEdge: accentEdge, isHighlighted: highlighted))
  }
}

extension NeoBrutalistSurfaceModifier.AccentEdge? {
  func padding(size: CGFloat) -> EdgeInsets {
    switch self {
    case .none: return .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    case .some(.top): return .init(top: size, leading: 0, bottom: 0, trailing: 0)
    case .some(.leading): return .init(top: 0, leading: size, bottom: 0, trailing: 0)
    case .some(.trailing): return .init(top: 0, leading: 0, bottom: 0, trailing: size)
    case .some(.bottom): return .init(top: 0, leading: 0, bottom: size, trailing: 0)
    }
  }
}
