import SwiftUI

/// A menu component with Neo Brutalist styling.
public struct NeoBrutalistMenu<Label: View, Content: View>: View {

    private let label: Label
    private let content: Content
    private let size: NeoBrutalistButtonStyle.Size

    public init(
        size: NeoBrutalistButtonStyle.Size = .regular,
        @ViewBuilder content: () -> Content,
        @ViewBuilder label: () -> Label
    ) {
        self.size = size
        self.content = content()
        self.label = label()
    }

    public var body: some View {
        Menu {
            content
        } label: {
            label
        }
        .menuStyle(NeoBrutalistMenuStyle(size: size))
    }
}

/// Custom menu style for Neo Brutalist aesthetics.
public struct NeoBrutalistMenuStyle: MenuStyle {
    private let size: NeoBrutalistButtonStyle.Size

    public init(size: NeoBrutalistButtonStyle.Size = .regular) {
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .buttonStyle(.neoBrutalist(size: size))
    }
}

/// A menu item with Neo Brutalist styling for use inside menus.
public struct NeoBrutalistMenuItem<Label: View>: View {
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

extension NeoBrutalistMenu where Label == Text {
    /// Creates a menu with a text label.
    public init(
        _ title: String,
        size: NeoBrutalistButtonStyle.Size = .regular,
        @ViewBuilder content: () -> Content
    ) {
        self.init(size: size, content: content) {
            Text(title)
        }
    }
}

extension NeoBrutalistMenu where Label == HStack<TupleView<(Text, Image)>> {
    /// Creates a menu with a text label and system icon.
    public init(
        _ title: String,
        systemImage: String,
        size: NeoBrutalistButtonStyle.Size = .regular,
        @ViewBuilder content: () -> Content
    ) {
        self.init(size: size, content: content) {
            HStack {
                Text(title)
                Image(systemName: systemImage)
            }
        }
    }
}

extension NeoBrutalistMenuItem where Label == Text {
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

extension NeoBrutalistMenuItem where Label == HStack<TupleView<(Image, Text)>> {
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
