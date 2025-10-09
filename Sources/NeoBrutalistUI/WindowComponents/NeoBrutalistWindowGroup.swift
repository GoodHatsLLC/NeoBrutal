import SwiftUI

public struct NeoBrutalistWindowGroup<Content: View, Overlay: View, Accessory: View>: Scene {
    public init(
        id: String,
        title: String,
        subTitle: String = "",
        buttons: [NeoBrutalist.WindowButtonConfiguration] = .defaultButtons,
        gestures: [NeoBrutalist.WindowGestureConfiguration] = .defaultGestures,
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
    var buttons: [NeoBrutalist.WindowButtonConfiguration]
    var gestures: [NeoBrutalist.WindowGestureConfiguration]
    var title: String
    var subTitle: String
    @ViewBuilder var content: () -> Content
    @ViewBuilder var overlay: () -> Overlay
    @ViewBuilder var accessory: () -> Accessory
    @Environment(\.nb) var nbTheme
    @State var safeArea: EdgeInsets = .init()
    @State var size: CGSize = .zero
    @State var window: NSWindow?

    public var body: some Scene {
        WindowGroup(id: id) {
            VStack(spacing: 0) {
                NeoBrutalist.WindowChrome(
                    window: window,
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
            .background {
                WindowReader { window in
                    self.window = window
                    guard let window else { return }
                        let requiredMask: NSWindow.StyleMask = [
                            .closable,
                            .miniaturizable,
                            .resizable,
                        ]

                        if !window.styleMask.contains(requiredMask) {
                            window.styleMask.formUnion(requiredMask)
                        }
                    window.titleVisibility = .hidden
                    window.isMovableByWindowBackground = false
                    window.backgroundColor = .clear

                window.standardWindowButton(.closeButton)?.isHidden = true
                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                window.standardWindowButton(.zoomButton)?.isHidden = true

                        if window.canBecomeKey {
                            window.makeKeyAndOrderFront(nil)
                        }
                }
            }
            .background(.ultraThinMaterial)
            .ignoresSafeArea()
            .overlay {
                overlay()
                    .safeAreaPadding(.top, size.height)
                    .ignoresSafeArea()
            }
            .clipShape(RoundedRectangle(cornerRadius: nbTheme.windowRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: nbTheme.windowRadius, style: .continuous).strokeBorder(nbTheme.windowBorderColor.color, lineWidth: nbTheme.windowBorder)
            }
            .offset(-nbTheme.windowShadowOffset / 2.0)
            .background {
                RoundedRectangle(cornerRadius: nbTheme.windowRadius)
                    .fill(nbTheme.windowShadowColor.color.opacity(nbTheme.shadowOpacity))
                    .offset(nbTheme.windowShadowOffset / 2.0)
            }
            .padding(.horizontal, nbTheme.windowShadowOffset.width / 2.0)
            .padding(.vertical, nbTheme.windowShadowOffset.height / 2.0)
            .windowFullScreenBehavior(.enabled)
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        .windowBackgroundDragBehavior(.disabled)
        .windowIdealPlacement { content, context in
            let displayBounds = context.defaultDisplay.visibleRect
            let proposal = ProposedViewSize(
                width: nil, height: displayBounds.height)
            let contentSize = content.sizeThatFits(proposal)
            return .init(
                width: contentSize.width,
                height: contentSize.height)
             }
    }

}
