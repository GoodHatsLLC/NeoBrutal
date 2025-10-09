import SwiftUI

/// A collapsible content container that applies the Neo Brutalist treatment.
public struct NeoBrutalistDisclosureGroup<Label: View, Content: View>: View {
  @Environment(\.nb) private var nbTheme

  private let label: () -> Label
  private let content: () -> Content
  private let accentEdge: NeoBrutalistSurfaceModifier.AccentEdge?
  private let highlighted: Bool
  private let showsDivider: Bool
  private let contentSpacing: CGFloat
  private let animation: Animation
  private let isExpandedBinding: Binding<Bool>?

  @State private var internalExpanded: Bool

  public init(
    isExpanded: Binding<Bool>? = nil,
    accentEdge: NeoBrutalistSurfaceModifier.AccentEdge? = .leading,
    highlighted: Bool = false,
    showsDivider: Bool = true,
    contentSpacing: CGFloat = NeoBrutalist.Spacing.small.rawValue,
    animation: Animation = .spring(response: 0.35, dampingFraction: 0.78),
    initiallyExpanded: Bool = false,
    @ViewBuilder label: @escaping () -> Label,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.label = label
    self.content = content
    self.isExpandedBinding = isExpanded
    self.accentEdge = accentEdge
    self.highlighted = highlighted
    self.showsDivider = showsDivider
    self.contentSpacing = contentSpacing
    self.animation = animation
    self._internalExpanded = State(initialValue: isExpanded?.wrappedValue ?? initiallyExpanded)
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      header
        .padding(.bottom, isExpanded ? contentSpacing : 0)

      if isExpanded {
        if showsDivider {
          divider
        }

        expandedContent
      }
    }
    .padding()
    .neoBrutalistSurface(accentEdge: accentEdge, highlighted: highlighted)
    .animation(animation, value: isExpanded)
  }

  private var header: some View {
    Button(action: toggleExpanded) {
      HStack(spacing: 14) {
        label()
          .font(nbTheme.typography.titleFont)
          .foregroundStyle(.nb.textPrimary)

        Spacer(minLength: 0)

        indicator
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .buttonStyle(.plain)
  }

  private var divider: some View {
    Divider()
      .overlay(.nb.surface.highlight.opacity(0.5))
      .padding(.bottom, contentSpacing)
  }

  private var expandedContent: some View {
    content()
      .font(nbTheme.typography.bodyFont)
      .foregroundStyle(.nb.textPrimary)
      .frame(maxWidth: .infinity, alignment: .leading)
      .transition(.move(edge: .top).combined(with: .opacity))
  }

  private var indicator: some View {
    Group {
      if isExpanded {
        ZStack {
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(.nb.accent.primary.opacity(0.24))
            .overlay(
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.nb.accent.highlight, lineWidth: nbTheme.borderWidth * 0.9)
            )

          Text("-")
            .font(nbTheme.typography.monoFont)
            .foregroundStyle(.nb.textPrimary)
            .offset(y: -0.6)
        }
      } else {
        ZStack {
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(.nb.surface.secondary.opacity(0.65))
            .overlay(
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.nb.accent.primary, lineWidth: nbTheme.borderWidth * 0.9)
            )

          Text("+")
            .font(nbTheme.typography.monoFont)
            .foregroundStyle(.nb.textPrimary)
        }
      }
    }
    .frame(width: 32, height: 32)
  }

  private var resolvedIsExpanded: Binding<Bool> {
    if let binding = isExpandedBinding {
      return binding
    }

    return Binding(
      get: { internalExpanded },
      set: { internalExpanded = $0 }
    )
  }

  private var isExpanded: Bool {
    resolvedIsExpanded.wrappedValue
  }

  private func toggleExpanded() {
    let binding = resolvedIsExpanded
    withAnimation(animation) {
      binding.wrappedValue.toggle()
    }
  }
}
