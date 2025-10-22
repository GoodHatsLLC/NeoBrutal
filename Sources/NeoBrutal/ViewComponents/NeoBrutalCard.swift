import SwiftUI

/// A segmented content container
public struct NeoBrutalCard<Content: View>: View {
  private let title: String?
  private let subtitle: String?
  private let icon: Image?
  private let accentEdge: NeoBrutalSurfaceModifier.AccentEdge?
  private let highlighted: Bool
  private let content: Content

  @Environment(\.nb) private var nbTheme

  public init(
    title: String? = nil,
    subtitle: String? = nil,
    icon: Image? = nil,
    accentEdge: NeoBrutalSurfaceModifier.AccentEdge? = .leading,
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
          .overlay(.nb.surface.highlight.opacity(0.4))
      }

      content
        .font(nbTheme.typography.bodyFont)
        .foregroundStyle(.nb.textPrimary)
    }
    .padding()
    .neoBrutalSurface(accentEdge: accentEdge, highlighted: highlighted)
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
            .foregroundStyle(.nb.accent.highlight)
        }

        VStack(alignment: .leading, spacing: 4) {
          if let title {
            Text(title)
              .font(nbTheme.typography.titleFont)
              .foregroundStyle(.nb.accent.highlight)
          }

          if let subtitle {
            Text(subtitle.uppercased())
              .font(nbTheme.typography.monoFont)
              .foregroundStyle(.nb.textMuted)
              .kerning(1.2)
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
