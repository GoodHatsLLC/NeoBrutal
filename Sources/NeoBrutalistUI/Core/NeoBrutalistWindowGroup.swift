import SwiftUI

public struct NeoBrutalistWindowGroup<Content: View, Overlay: View, Accessory: View>: Scene {
    public init(
        id: String,
        buttons: [WindowChromeButtonConfiguration] = .defaultButtons,
        gestures: [WindowGestureConfiguration] = .defaultGestures,
        title: String,
        subTitle: String = "",
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlay: @escaping () -> Overlay,
        @ViewBuilder accessory: @escaping () -> Accessory = { EmptyView() }
    ) {
        self.id = id
        self.buttons = buttons
        self.gestures = gestures
        self.title = title
        self.subTitle = subTitle
        self.content = content
        self.overlay = overlay
        self.accessory = accessory
    }

    var id: String
    var buttons: [WindowChromeButtonConfiguration]
    var gestures: [WindowGestureConfiguration]
    var title: String
    var subTitle: String = ""
    @ViewBuilder var content: () -> Content
    @ViewBuilder var overlay: () -> Overlay
    @ViewBuilder var accessory: () -> Accessory
    @Environment(\.neoBrutalistTheme) var theme
    @State var safeArea: EdgeInsets = .init()
    @State var size: CGSize = .zero

    public var body: some Scene {
        WindowGroup(id: id) {
            VStack(spacing: 0) {
                    NeoBrutalistWindowChrome(
                        buttons: buttons,
                        gestures: gestures,
                        title: title,
                        subtitle: subTitle,
                        accessory: accessory
                    )
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .readingSize(into: $size, safeArea: $safeArea)
                content()
            }
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .overlay {
                overlay()
                    .safeAreaPadding(.top, size.height)
                    .ignoresSafeArea()
            }
            .border(.primary.opacity(0.8))
            .neoBrutalistShadow(color: .primary.opacity(theme.shadowOpacity), radius: theme.shadowRadius, offset: theme.shadowOffset)
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        .windowBackgroundDragBehavior(.disabled)

    }

}
extension View {
    func readingSize(into size: Binding<CGSize>, safeArea: Binding<EdgeInsets> = .constant(.init())) -> some View {
    self
      .background {
        GeometryReader { proxy in
          Color.clear
                .task(id: AnyHashable(many: proxy.size, Edges(insets: proxy.safeAreaInsets))) {
              size.wrappedValue = proxy.size
                safeArea.wrappedValue = proxy.safeAreaInsets
            }
        }
        .hidden()
      }
  }
}

struct Edges: Hashable {
    public var top: CGFloat
    public var leading: CGFloat
    public var bottom: CGFloat
    public var trailing: CGFloat
    init(insets: EdgeInsets) {
        self.top = insets.top
        self.leading = insets.leading
        self.bottom = insets.bottom
        self.trailing = insets.trailing
    }

}

extension AnyHashable {
  init<each T: Hashable>(many: repeat each T) {
    var group: [AnyHashable] = []
    for a in repeat each many {
      group.append(AnyHashable(a))
    }
    self = .init(group)
  }
}
