import SwiftUI

public struct NeoBrutalistWindowGroup<Content: View>: Scene {
    public init(id: String, title: String, subTitle: String = "", content: @escaping () -> Content)
    {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.content = content
    }

    var id: String
    var title: String
    var subTitle: String = ""
    @ViewBuilder var content: () -> Content
    @Environment(\.neoBrutalistTheme) var theme

    public var body: some Scene {
        WindowGroup(id: id) {
            content()
                .safeAreaInset(edge: .top) {
                    NeoBrutalistWindowChrome(
                        title: title,
                        subtitle: subTitle
                    )
                    .fixedSize(horizontal: false, vertical: true)
                    .neoBrutalistShadow(
                        color: Color.black.opacity(theme.shadowRadius == 0 ? 0.2 : 0.28),
                        radius: theme.shadowRadius,
                        offset: theme.shadowOffset,
                        clip: .horizontal
                    )
                    .ignoresSafeArea()
                }
        }
        .windowLevel(.floating)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)

    }

}
