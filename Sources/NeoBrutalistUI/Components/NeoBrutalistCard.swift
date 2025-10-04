import SwiftUI

/// A segmented content container with Neo Brutalist styling.
public struct NeoBrutalistCard<Content: View>: View {
    private let title: String?
    private let subtitle: String?
    private let icon: Image?
    private let accentEdge: NeoBrutalistSurfaceModifier.AccentEdge?
    private let highlighted: Bool
    private let content: Content

    @Environment(\.neoBrutalistTheme) private var theme

    public init(
        title: String? = nil,
        subtitle: String? = nil,
        icon: Image? = nil,
        accentEdge: NeoBrutalistSurfaceModifier.AccentEdge? = .leading,
        highlighted: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.accentEdge = accentEdge
        self.highlighted = highlighted
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if hasHeader {
                header
                Divider()
                    .overlay(theme.surface.highlight.color.opacity(0.4))
            }

            content
                .font(theme.typography.bodyFont)
                .foregroundColor(theme.textPrimary.color)
        }
        .padding()
        .neoBrutalistSurface(accentEdge: accentEdge, highlighted: highlighted)
    }

    @ViewBuilder
    private var header: some View {
        if title != nil || subtitle != nil || icon != nil {
            HStack(alignment: .center, spacing: 12) {
                if let icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(theme.accent.highlight.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    if let title {
                        Text(title)
                            .font(theme.typography.titleFont)
                            .foregroundColor(theme.accent.highlight.color)
                    }

                    if let subtitle {
                        Text(subtitle.uppercased())
                            .font(theme.typography.monoFont)
                            .foregroundColor(theme.textMuted.color)
                            .neoKerning(1.2)
                    }
                }

                Spacer(minLength: 0)
            }
        }
    }

    private var hasHeader: Bool {
        title != nil || subtitle != nil || icon != nil
    }
}
