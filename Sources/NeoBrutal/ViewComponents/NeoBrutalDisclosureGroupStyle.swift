import SwiftUI

/// A collapsible content container that applies the Neo Brutalist treatment.
struct NeoBrutalDisclosureGroup<Label: View, Content: View>: View {
  @Environment(\.nb) private var nbTheme
  @Environment(\.controlSize) private var controlSize

  private let label: () -> Label
  private let content: () -> Content
  private let accentEdge: NeoBrutalSurfaceModifier.AccentEdge?
  private let highlighted: Bool
  private let showsDivider: Bool
  @Binding var isExpanded: Bool

  init(
    isExpanded: Binding<Bool>,
    accentEdge: NeoBrutalSurfaceModifier.AccentEdge? = .leading,
    highlighted: Bool = false,
    showsDivider: Bool = true,
    @ViewBuilder label: @escaping () -> Label,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.label = label
    self.content = content
    self._isExpanded = isExpanded
    self.accentEdge = accentEdge
    self.highlighted = highlighted
    self.showsDivider = showsDivider
  }

  @Namespace var namespace

  var body: some View {
    VStack {
      if !isExpanded {
        Button {
          isExpanded.toggle()
        } label: {
          label()
            .matchedGeometryEffect(
              id: "disclosureButtonLabel",
              in: namespace,
              isSource: true
            )
        }
        .buttonStyle(NeoBrutalButtonStyle(displayShadow: true))
        .compositingGroup()
      } else {
        VStack(alignment: .leading, spacing: controlSize.spacing) {
          Button {
            isExpanded.toggle()
          } label: {
            label()
              .matchedGeometryEffect(
                id: "disclosureButtonLabel",
                in: namespace,
                isSource: false
              )
          }
          .buttonStyle(NeoBrutalButtonStyle(displayShadow: false))
          .compositingGroup()
          if isExpanded {
            if showsDivider {
              Divider()
                .overlay(.nb.surface.highlight.opacity(0.5))
            }
            expandedContent
          }
        }
        .padding()
        .neoBrutalSurface(accentEdge: accentEdge, highlighted: highlighted)
        .compositingGroup()
        .transition(.scale(scale: 0.01, anchor: .bottomLeading).combined(with: .opacity))
      }
    }
    .animation(.snappy, value: isExpanded)
  }

  private var expandedContent: some View {
    content()
      .font(nbTheme.typography.bodyFont)
      .foregroundStyle(.nb.textPrimary)
      .frame(maxWidth: .infinity, alignment: .leading)
  }

}

extension DisclosureGroupStyle where Self == NeoBrutalDisclosureGroupStyle {
  public static var neoBrutal: NeoBrutalDisclosureGroupStyle {
    NeoBrutalDisclosureGroupStyle()
  }
}

public struct NeoBrutalDisclosureGroupStyle: DisclosureGroupStyle {

  @Environment(\.nb) var nb
  @Environment(\.controlSize) var controlSize

  public func makeBody(configuration: Configuration) -> some View {
    NeoBrutalDisclosureGroup(
      isExpanded: configuration.$isExpanded,
      accentEdge: .leading,
      highlighted: false,
      showsDivider: true
    ) {
      configuration.label
    } content: {
      configuration.content
    }
  }

}
