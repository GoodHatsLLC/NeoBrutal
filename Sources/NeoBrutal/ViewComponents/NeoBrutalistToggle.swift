import SwiftUI

/// A chunky toggle control that matches the Neo Brutalist aesthetic.
public struct NeoBrutalToggleStyle: ToggleStyle {

  @Namespace var focusScope
  @Environment(\.nb) private var nbTheme
  @Environment(\.controlSize) private var controlSize

  public init() {
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 0) {
      configuration.label
        .font(nbTheme.typography.bodyFont)
        .foregroundStyle(.nb.textPrimary)
      Rectangle()
        .fill(.clear)
        .frame(width: controlSize.spacing, height: 1)
      toggle(configuration: configuration)
    }
    .focusScope(focusScope)
  }

  @ViewBuilder
  private func toggle(configuration: Configuration) -> some View {
    let trackHeight = controlSize.trackSize.height
    let knobSide = trackHeight - 10
    let trackCornerRadius: CGFloat = nbTheme.controlCornerRadius

    ZStack(alignment: configuration.isOn ? .trailing : .leading) {
      RoundedRectangle(cornerRadius: nbTheme.controlCornerRadius / 2.0, style: .continuous)
        .fill(configuration.isOn ? Color.nb.accent.primary : Color.nb.surface.primary)
        .fill(Color.nb.accent.primary.opacity(0.2))
        .overlay(
          RoundedRectangle(cornerRadius: nbTheme.controlCornerRadius / 2.0, style: .continuous)
            .stroke(Color.black.opacity(0.1), lineWidth: 1)
        )
        .frame(width: knobSide, height: knobSide)
        .neoBrutalShadow(
          color: .black.opacity(nbTheme.shadowOpacity),
          radius: nbTheme.shadowRadius * controlSize.shadowMultiple,
          offset: .init(
            width: nbTheme.shadowOffset.width * controlSize.shadowMultiple * 0.5,
            height: nbTheme.shadowOffset.height * controlSize.shadowMultiple * 0.5
          ),
          cornerRadius: nbTheme.controlCornerRadius / 2.0
        )
        .padding(.horizontal, nbTheme.shadowOffset.width)
      RoundedRectangle(cornerRadius: trackCornerRadius, style: .continuous)
        .fill(
          configuration.isOn
            ? Color.nb.accent.primary.opacity(0.18) : Color.nb.surface.secondary.opacity(0.6)
        )
        .overlay(
          RoundedRectangle(cornerRadius: trackCornerRadius, style: .continuous)
            .stroke(
              .nb.accent.primary.opacity(configuration.isOn ? 1 : 0.2),
              lineWidth: nbTheme.borderWidth
            )
        )
        .frame(width: controlSize.trackSize.width, height: controlSize.trackSize.height)
    }
    .padding(
      .vertical,
      max(max(nbTheme.shadowOffset.height, nbTheme.shadowOffset.width), controlSize.spacing)
    )
    .contentShape(Rectangle())
    .padding(.horizontal, nbTheme.borderWidth)
    .overlay {
      Button {
        configuration.isOn.toggle()
      } label: {
        Color.white.blendMode(.darken)
      }
      .buttonStyle(.plain)
      .prefersDefaultFocus(in: focusScope)
    }
  }
}

extension ToggleStyle where Self == NeoBrutalToggleStyle {
  public static var neoBrutal: NeoBrutalToggleStyle {
    NeoBrutalToggleStyle()
  }
}
