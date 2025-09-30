import SwiftUI

public struct NeoBrutalistWindowGroup<Content: View, Accessory: View>: Scene {
    public init(
        id: String,
        buttons: [WindowChromeButtonConfiguration] = .defaultButtons,
        gestures: [WindowGestureConfiguration] = .defaultGestures,
        title: String,
        subTitle: String = "",
        content: @escaping () -> Content,
        accessory: @escaping () -> Accessory = { EmptyView() }
    ) {
        self.id = id
        self.buttons = buttons
        self.gestures = gestures
        self.title = title
        self.subTitle = subTitle
        self.content = content
        self.accessory = accessory
    }

    var id: String
    var buttons: [WindowChromeButtonConfiguration]
    var gestures: [WindowGestureConfiguration]
    var title: String
    var subTitle: String = ""
    var accessory: () -> Accessory

    @ViewBuilder var content: () -> Content
    @Environment(\.neoBrutalistTheme) var theme

    public var body: some Scene {
        WindowGroup(id: id) {
            content()
                .safeAreaInset(edge: .top) {
                    NeoBrutalistWindowChrome(
                        buttons: buttons,
                        gestures: gestures,
                        title: title,
                        subtitle: subTitle,
                        accessory: accessory
                    )
                    .fixedSize(horizontal: false, vertical: true)
                    .neoBrutalistShadow(
                        color: Color.primary.opacity(theme.shadowOpacity),
                        radius: theme.shadowRadius,
                        offset: theme.shadowOffset,
                        clip: .horizontal
                    )
                }
                .ignoresSafeArea()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .windowBackgroundDragBehavior(.disabled)

    }

}
