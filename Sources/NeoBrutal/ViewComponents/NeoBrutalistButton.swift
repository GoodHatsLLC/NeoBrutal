import SwiftUI

/// A bold, tactile button style inspired by Neo Brutalism.
public struct NeoBrutalButtonStyle: ButtonStyle {

  @Environment(\.nb) private var nbTheme
  @Environment(\.controlSize) private var size
  private let displayShadow: Bool
  @Environment(\.isEnabled) var isEnabled

  public init(displayShadow: Bool = true) {
    self.displayShadow = displayShadow
  }

  public func makeBody(configuration: Configuration) -> some View {
    let pressOffset = configuration.isPressed ? nbTheme.shadowOffset : .zero

    configuration.label
      .font(nbTheme.typography.controlFont(at: size))
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
    let shadowColor = Color.primary.opacity(nbTheme.shadowOpacity)

    if isEnabled {
      baseShape
        .fill(.nb.surface.primary)
        .overlay(baseShape.stroke(.nb.accent.primary, lineWidth: nbTheme.borderWidth))
        .overlay(
          baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: nbTheme.borderWidth)
        )
        .compositingGroup()
        .neoBrutalShadow(
          color: shadowColor,
          radius: nbTheme.shadowRadius,
          offset: nbTheme.shadowOffset,
          isEnabled: !isPressed && displayShadow,
          cornerRadius: nbTheme.cornerRadius
        )
    } else {
      // For disabled state, we need to compute a mixed color
      let disabledFill = nbTheme.surface.secondary.color.mix(with: .gray, by: 0.1)
      baseShape
        .fill(disabledFill)
        .overlay(baseShape.stroke(.primary, lineWidth: nbTheme.borderWidth))
        .overlay(
          baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: nbTheme.borderWidth)
        )
        .compositingGroup()
        .neoBrutalShadow(
          color: shadowColor,
          radius: nbTheme.shadowRadius,
          offset: nbTheme.shadowOffset,
          isEnabled: !isPressed && displayShadow,
          cornerRadius: nbTheme.cornerRadius
        )
    }
  }

  private var baseShape: RoundedRectangle {
    RoundedRectangle(cornerRadius: nbTheme.cornerRadius, style: .continuous)
  }
}

extension ButtonStyle where Self == NeoBrutalButtonStyle {
  public static func neoBrutal(
    displayShadow: Bool = true
  ) -> NeoBrutalButtonStyle {
    NeoBrutalButtonStyle(displayShadow: displayShadow)
  }
}

/// Convenience view that wraps a standard `Button` applying the Neo Brutalist style.
public struct NeoBrutalButton<LabelView: View>: View {
  private let action: () -> Void
  private let label: LabelView
  private let displayShadow: Bool
  @Environment(\.isEnabled) var isEnabled
  @Environment(\.self) var environment
  @Environment(\.controlSize) private var size
  @Environment(\.nb) private var nbTheme
  @ScaledMetric(relativeTo: .body) var fontSize = 18

  public init(
    displayShadow: Bool = true,
    action: @escaping () -> Void,
    @ViewBuilder label: () -> LabelView
  ) {
    self.action = action
    self.label = label()
    self.displayShadow = displayShadow
  }

  public init(
    title: String,
    systemImage: String,
    displayShadow: Bool = true,
    action: @escaping () -> Void
  ) where LabelView == Label<Text, Image> {
    self.action = action
    self.label = Label(title, systemImage: systemImage)
    self.displayShadow = displayShadow
  }

  public var body: some View {
    Button(action: action) {
      label.foregroundStyle(.tint)
    }
    .buttonStyle(.neoBrutal(displayShadow: displayShadow))
  }
}

extension ControlSize {
  var padding: EdgeInsets {
    switch self {
    case .small: return EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    case .mini: return EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
    case .regular: return EdgeInsets(top: 14, leading: 14, bottom: 14, trailing: 14)
    case .large: return EdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18)
    case .extraLarge: return EdgeInsets(top: 22, leading: 22, bottom: 22, trailing: 22)
    @unknown default: return EdgeInsets(top: 14, leading: 14, bottom: 14, trailing: 14)
    }
  }
}
