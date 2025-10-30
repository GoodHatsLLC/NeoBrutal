import SwiftUI

/// A fully custom dropdown menu with Neo Brutalist styling.
/// Supports both unpressed (closed) and pressed/selection (open) states.
public struct NeoBrutalDropdown<SelectionValue: Hashable, Content: View>: View {

  @Environment(\.nb) private var nbTheme
  @Environment(\.controlSize) private var controlSize
  @State private var isExpanded: Bool = false

  @Binding private var selection: SelectionValue
  private let options: [SelectionValue]
  private let label: (SelectionValue) -> Content
  private let displayShadow: Bool

  public init(
    selection: Binding<SelectionValue>,
    options: [SelectionValue],
    displayShadow: Bool = true,
    @ViewBuilder label: @escaping (SelectionValue) -> Content
  ) {
    self._selection = selection
    self.options = options
    self.label = label
    self.displayShadow = displayShadow
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      // Trigger button (unpressed state when closed)
      triggerButton

      // Dropdown list (selection-in-progress state when open)
      if isExpanded {
        dropdownList
      }
    }
  }

  private var triggerButton: some View {
    Button {
      withAnimation(.spring(response: 0.28, dampingFraction: 0.7)) {
        isExpanded.toggle()
      }
    } label: {
      HStack {
        label(selection)
        Spacer()
        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
          .font(nbTheme.typography.controlFont(at: controlSize))
      }
      .font(nbTheme.typography.controlFont(at: controlSize))
      .foregroundStyle(.nb.textPrimary)
      .padding(controlSize.dropdownPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        baseShape
          .fill(.nb.surface.primary)
          .overlay(baseShape.stroke(.nb.accent.primary, lineWidth: nbTheme.borderWidth))
          .overlay(
            baseShape.stroke(.nb.surface.highlight.opacity(0.6), lineWidth: nbTheme.borderWidth)
          )
      )
      .compositingGroup()
      .neoBrutalShadow(
        color: Color.primary.opacity(nbTheme.shadowOpacity),
        radius: nbTheme.shadowRadius,
        offset: nbTheme.shadowOffset.applying(
          .init(scaleX: controlSize.shadowMultiple, y: controlSize.shadowMultiple)
        ),
        isEnabled: displayShadow,
        cornerRadius: nbTheme.controlCornerRadius
      )
    }
    .buttonStyle(PlainButtonStyle())
  }

  private var dropdownList: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(Array(options.enumerated()), id: \.element) { index, option in
        dropdownRow(for: option, isLast: index == options.count - 1)
      }
    }
    .background(.nb.background.primary)
    .overlay(
      RoundedRectangle(cornerRadius: nbTheme.controlCornerRadius, style: .continuous)
        .stroke(.nb.accent.secondary, lineWidth: nbTheme.borderWidth)
    )
    .compositingGroup()
    .neoBrutalShadow(
      color: Color.primary.opacity(nbTheme.shadowOpacity * 1.2),
      radius: nbTheme.shadowRadius,
      offset: CGSize(
        width: nbTheme.shadowOffset.width * 0.7,
        height: nbTheme.shadowOffset.height * 1.1
      ),
      isEnabled: displayShadow,
      cornerRadius: nbTheme.controlCornerRadius
    )
    .padding(.top, 4)
    .transition(.asymmetric(
      insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
      removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
    ))
  }

  private func dropdownRow(for option: SelectionValue, isLast: Bool) -> some View {
    Button {
      withAnimation(.spring(response: 0.28, dampingFraction: 0.7)) {
        selection = option
        isExpanded = false
      }
    } label: {
      HStack {
        label(option)
        Spacer()
        if option == selection {
          Image(systemName: "checkmark")
            .font(nbTheme.typography.controlFont(at: controlSize))
            .foregroundStyle(.nb.accent.primary)
        }
      }
      .font(nbTheme.typography.controlFont(at: controlSize))
      .foregroundStyle(.nb.textPrimary)
      .padding(controlSize.dropdownRowPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(rowBackground(for: option))
      .contentShape(Rectangle())
    }
    .buttonStyle(DropdownRowButtonStyle())
  }

  @ViewBuilder
  private func rowBackground(for option: SelectionValue) -> some View {
    if option == selection {
      RoundedRectangle(cornerRadius: nbTheme.controlCornerRadius - 2, style: .continuous)
        .fill(.nb.accent.primary.opacity(0.15))
    } else {
      Color.clear
    }
  }

  private var baseShape: RoundedRectangle {
    RoundedRectangle(cornerRadius: nbTheme.controlCornerRadius, style: .continuous)
  }
}

// MARK: - Dropdown Row Button Style

private struct DropdownRowButtonStyle: ButtonStyle {
  @Environment(\.nb) private var nbTheme

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        configuration.isPressed
          ? AnyShapeStyle(.nb.accent.highlight.opacity(0.2))
          : AnyShapeStyle(Color.clear)
      )
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

// MARK: - Control Size Extensions

extension ControlSize {
  var dropdownPadding: EdgeInsets {
    switch self {
    case .mini: return EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
    case .small: return EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
    case .regular: return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    case .large: return EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
    case .extraLarge: return EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24)
    @unknown default: return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
    }
  }

  var dropdownRowPadding: EdgeInsets {
    switch self {
    case .mini: return EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
    case .small: return EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
    case .regular: return EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
    case .large: return EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
    case .extraLarge: return EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
    @unknown default: return EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
    }
  }
}

// MARK: - Convenience Initializers

extension NeoBrutalDropdown where Content == Text {
  /// Creates a dropdown with text labels for each option.
  public init(
    selection: Binding<SelectionValue>,
    options: [SelectionValue],
    displayShadow: Bool = true
  ) where SelectionValue: CustomStringConvertible {
    self.init(
      selection: selection,
      options: options,
      displayShadow: displayShadow
    ) { value in
      Text(value.description)
    }
  }
}

extension NeoBrutalDropdown where Content == HStack<TupleView<(Image, Text)>>, SelectionValue: CustomStringConvertible {
  /// Creates a dropdown with icon and text labels for each option.
  public init(
    selection: Binding<SelectionValue>,
    options: [SelectionValue],
    displayShadow: Bool = true,
    systemImage: @escaping (SelectionValue) -> String
  ) {
    self.init(
      selection: selection,
      options: options,
      displayShadow: displayShadow
    ) { value in
      HStack {
        Image(systemName: systemImage(value))
        Text(value.description)
      }
    }
  }
}
