import SwiftUI

public struct NeoBrutalWindowGroup<Content: View, Overlay: View, Accessory: View, Icon: View>: Scene
{
  public init(
    id: String,
    title: Text,
    subTitle: Text? = nil,
    image: Image? = nil,
    icon: @autoclosure () -> Icon = EmptyView(),
    buttons: [NeoBrutal.WindowButtonConfiguration] = .defaultButtons,
    gestures: [NeoBrutal.WindowGestureConfiguration] = .defaultGestures,
    @ViewBuilder content: @escaping () -> Content,
    @ViewBuilder overlay: @escaping () -> Overlay,
    @ViewBuilder accessory: @escaping () -> Accessory = { EmptyView() },
  ) {
    self.id = id
    self.buttons = buttons
    self.gestures = gestures
    self.title = title
    self.subTitle = subTitle
    self.content = content
    self.overlay = overlay
    self.accessory = accessory
    self.icon = icon()
  }

  var id: String
  var buttons: [NeoBrutal.WindowButtonConfiguration]
  var gestures: [NeoBrutal.WindowGestureConfiguration]
  var title: Text
  var subTitle: Text?
  var icon: Icon
  @ViewBuilder var content: () -> Content
  @ViewBuilder var overlay: () -> Overlay
  @ViewBuilder var accessory: () -> Accessory
  @Environment(\.nb) var nbTheme
  @State var safeArea: EdgeInsets = .init()
  @State var size: CGSize = .zero
  @State var window: NSWindow?
  @State var focusDisabled: Bool = true

  public var body: some Scene {
    WindowGroup(id: id) {
      VStack(spacing: 0) {
        NeoBrutal.WindowChrome(
          window: window,
          buttons: buttons,
          gestures: gestures,
          title: title,
          subtitle: subTitle,
          icon: icon,
          accessory: accessory
        )
        .gesture(WindowDragGesture())
        .allowsWindowActivationEvents()
        content()
          .clipped()
      }
      .ignoresSafeArea()
      .frame(maxWidth: .infinity)
      .overlay {
        overlay()
      }
      .ignoresSafeArea()
      .background(.ultraThinMaterial)
      .background {
        WindowReader { window in
          self.window = window
          guard let window else { return }
          let requiredMask: NSWindow.StyleMask = [
            .closable,
            .miniaturizable,
            .resizable,
            .fullSizeContentView,
          ]
          if !window.styleMask.contains(requiredMask) {
            window.styleMask.formUnion(requiredMask)
          }
          window.standardWindowButton(.closeButton)?.isHidden = true
          window.standardWindowButton(.miniaturizeButton)?.isHidden = true
          window.standardWindowButton(.zoomButton)?.isHidden = true
          window.titleVisibility = .hidden
          window.titlebarAppearsTransparent = true
          window.isMovableByWindowBackground = false
          window.isOpaque = false
          window.backgroundColor = .clear
          window.hasShadow = true
        }
      }
      .focusEffectDisabled(focusDisabled)
      .onKeyPress(
        keys: [.tab],
        action: { _ in
          focusDisabled = false
          return .ignored
        }
      )
      .onKeyPress(
        .escape,
        action: {
          focusDisabled = true
          return .handled
        }
      )
      .windowFullScreenBehavior(.enabled)
    }
    .windowStyle(.hiddenTitleBar)
    .windowToolbarStyle(.unifiedCompact)
    .windowBackgroundDragBehavior(.enabled)
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
