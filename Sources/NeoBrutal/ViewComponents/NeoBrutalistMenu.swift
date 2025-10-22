import SwiftUI

/// A menu component with Neo Brutalist styling.
public struct NeoBrutalMenu<Label: View, Content: View>: View {

  private let label: Label
  private let content: Content

  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label
  ) {
    self.content = content()
    self.label = label()
  }

  public var body: some View {
    Menu {
      content
    } label: {
      label
    }
  }
}

/// A menu item with Neo Brutalist styling for use inside menus.
public struct NeoBrutalMenuItem<Label: View>: View {
  @Environment(\.nb) private var nbTheme

  private let action: () -> Void
  private let label: Label
  private let destructive: Bool

  public init(
    destructive: Bool = false,
    action: @escaping () -> Void,
    @ViewBuilder label: () -> Label
  ) {
    self.action = action
    self.label = label()
    self.destructive = destructive
  }

  public var body: some View {
    Button(action: action) {
      label
        .font(nbTheme.typography.bodyFont)
        .foregroundStyle(destructive ? AnyShapeStyle(.red) : AnyShapeStyle(.nb.textPrimary))
    }
  }
}

// MARK: - Convenience Initializers

extension NeoBrutalMenu where Label == Text {
  /// Creates a menu with a text label.
  public init(
    _ title: String,
    @ViewBuilder content: () -> Content
  ) {
    self.init(content: content) {
      Text(title)
    }
  }
}

extension NeoBrutalMenu where Label == HStack<TupleView<(Text, Image)>> {
  /// Creates a menu with a text label and system icon.
  public init(
    _ title: String,
    systemImage: String,
    @ViewBuilder content: () -> Content
  ) {
    self.init(content: content) {
      HStack {
        Text(title)
        Image(systemName: systemImage)
      }
    }
  }
}

extension NeoBrutalMenuItem where Label == Text {
  /// Creates a menu item with a text label.
  public init(
    _ title: String,
    destructive: Bool = false,
    action: @escaping () -> Void
  ) {
    self.init(destructive: destructive, action: action) {
      Text(title)
    }
  }
}

extension NeoBrutalMenuItem where Label == HStack<TupleView<(Image, Text)>> {
  /// Creates a menu item with a system icon and text label.
  public init(
    _ title: String,
    systemImage: String,
    destructive: Bool = false,
    action: @escaping () -> Void
  ) {
    self.init(destructive: destructive, action: action) {
      HStack {
        Image(systemName: systemImage)
        Text(title)
      }
    }
  }
}

