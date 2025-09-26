import SwiftUI

/// A collapsible content container that applies the Neo Brutalist treatment.
public struct NeoBrutalistDisclosureGroup<Label: View, Content: View>: View {
    @Environment(\.neoBrutalistTheme) private var theme

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
        .neoBrutalistSurface(accentEdge: accentEdge, highlighted: highlighted, padding: 20)
        .animation(animation, value: isExpanded)
    }

    private var header: some View {
        Button(action: toggleExpanded) {
            HStack(spacing: 14) {
                label()
                    .font(theme.typography.titleFont)
                    .foregroundColor(theme.textPrimary.color)

                Spacer(minLength: 0)

                indicator
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.plain)
    }

    private var divider: some View {
        Divider()
            .overlay(theme.surface.highlight.color.opacity(0.5))
            .padding(.bottom, contentSpacing)
    }

    private var expandedContent: some View {
        content()
            .font(theme.typography.bodyFont)
            .foregroundColor(theme.textPrimary.color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.move(edge: .top).combined(with: .opacity))
    }

    private var indicator: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(indicatorBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(indicatorBorder, lineWidth: theme.borderWidth * 0.9)
                )

            Text(isExpanded ? "-" : "+")
                .font(theme.typography.monoFont)
                .foregroundColor(theme.textPrimary.color)
                .offset(y: isExpanded ? -0.6 : 0)
        }
        .frame(width: 32, height: 32)
    }

    private var indicatorBackground: Color {
        isExpanded ? theme.accent.primary.color.opacity(0.24) : theme.surface.secondary.color.opacity(0.65)
    }

    private var indicatorBorder: Color {
        isExpanded ? theme.accent.highlight.color : theme.accent.primary.color
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
