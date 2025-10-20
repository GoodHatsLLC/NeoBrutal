import AppKit
import SwiftUI

extension NeoBrutal {
  @available(macOS 15.0, *)
  public struct WindowChrome<Icon: View, Accessory: View>: View {
    @Environment(\.nb) private var nbTheme

    private let title: Text
    private let subtitle: Text?
    private let icon: Icon?
    private let accessory: Accessory
    private let windowButtons: [NeoBrutal.WindowButtonConfiguration]
    private let windowGestures: [NeoBrutal.WindowGestureConfiguration]

    private let window: NSWindow?

    public init(
      window: NSWindow?,
      buttons: [NeoBrutal.WindowButtonConfiguration],
      gestures: [NeoBrutal.WindowGestureConfiguration],
      title: Text,
      subtitle: Text? = nil,
      icon: Icon,
      @ViewBuilder accessory: () -> Accessory
    ) {
      self.window = window
      self.title = title
      self.subtitle = subtitle
      self.accessory = accessory()
      self.icon = icon
      self.windowButtons = buttons
      self.windowGestures = gestures
    }
    init(
      window: NSWindow?,
      buttons: [NeoBrutal.WindowButtonConfiguration],
      gestures: [NeoBrutal.WindowGestureConfiguration],
      title: Text,
      subtitle: Text? = nil
    ) where Accessory == EmptyView, Icon == EmptyView {
      self.window = window
      self.title = title
      self.subtitle = subtitle
      self.accessory = EmptyView()
      self.icon = EmptyView()
      self.windowButtons = buttons
      self.windowGestures = gestures
    }

    public var body: some View {
      VStack(alignment: .leading) {
        HStack(alignment: .center, spacing: 0) {
          VStack(
            alignment: .leading,
            spacing: 4
          ) {
            title
              .font(nbTheme.typography.titleFont)
              .foregroundColor(nbTheme.textPrimary.color)
              .lineLimit(1)
              .allowsHitTesting(false)
              .fixedSize()
          }
          if let icon {
            Rectangle().fill(.clear).frame(width: 8)
            icon
          }
          Spacer()
        }
        .frame(maxWidth: .infinity)
        .safeAreaInset(edge: .leading, alignment: .center) {
          WindowControls(
            window: window,
            windowButtons: windowButtons
          )
          .padding(.horizontal)
        }
        .safeAreaInset(edge: .trailing, alignment: .center) {
          accessory
            .padding(.horizontal)
        }
        .padding(.vertical)
      }
      .fixedSize(horizontal: false, vertical: true)
      .background {
        if nbTheme.noiseOpacity > 0 {
          Rectangle()
            .fill(NeoBrutal.noise())
            .ignoresSafeArea()
            .opacity(nbTheme.noiseOpacity)
            .blendMode(.overlay)
            .allowsHitTesting(false)
        }
      }
      .background {
        Rectangle()
          .fill(nbTheme.surface.primary.color)
          .ignoresSafeArea()
          .onTapGesture(count: 2) {
            if let window {
              for gesture in windowGestures {
                switch gesture.gestureType {
                case .doubleTap:
                  gesture.action(window)
                }
              }
            }
          }
      }

    }

    private var accentHeight: CGFloat {
      max(nbTheme.borderWidth * 3, 8)
    }
  }

  struct WindowControls: View {
    let window: NSWindow?
    let windowButtons: [WindowButtonConfiguration]
    @State private var hover: Bool = false
    @Environment(\.nb) var nbTheme
    var body: some View {
      HStack {
        ForEach(windowButtons) { button in
          controlButton(button, hover: hover)
        }
      }
      .onContinuousHover { phase in
        switch phase {
        case .active:
          hover = true
        case .ended:
          hover = false
        }
      }
    }
    private func controlButton(
      _ control: WindowButtonConfiguration,
      hover: Bool
    )
      -> some View
    {

      StatefulView(initialState: (active: false, hovered: false)) { $s in
        let buttonState: WindowButtonConfiguration.ButtonState =
          switch (s.active, s.hovered) {
          case (true, _): .active
          case (_, true): .hovered
          case (_, _): .inactive
          }
        Button {
          if let window {
            control.action(window)
          }
        } label: {
          Circle()
            .fill(control.color(buttonState, window))
            .stroke(
              control.color(buttonState, window).mix(with: .black, by: 0.7).opacity(0.5),
              lineWidth: max(nbTheme.borderWidth * 0.6, 1)
            )
            .frame(
              width: nbTheme.windowButtonSize.width,
              height: nbTheme.windowButtonSize.height
            )
            .overlay {
              Circle()
                .inset(
                  by: max(
                    1,
                    min(
                      nbTheme.windowButtonSize.width,
                      nbTheme.windowButtonSize.height)
                      * 0.1)
                )
                .fill(
                  LinearGradient(
                    colors: [
                      s.active ? .black : .white.opacity(0.3),
                      .clear,
                    ], startPoint: .top,
                    endPoint: .bottom)
                )
                .blendMode(.softLight)
            }
            .overlay(
              control.icon
                .resizable(resizingMode: .tile)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.black)
                .fontWeight(.black)
                .opacity(
                  hover ? 0.7 : 0
                ).padding(
                  max(
                    2,
                    min(nbTheme.windowButtonSize.width, nbTheme.windowButtonSize.height)
                      * 0.22)
                )
            )
            .contentShape(Circle())
            .compositingGroup()
        }
        .buttonStyle(.unstyled)
        .accessibilityLabel(control.accessibilityLabel)
        .onTouchUpInside(downInside: $s.active)
        .onContinuousHover(perform: { phase in
          switch phase {
          case .active: s.hovered = true
          case .ended: s.hovered = false
          }
        })
        .disabled(window == nil)
      }
    }
  }

}

extension NeoBrutal {

  public struct WindowGestureConfiguration: Identifiable {
    public let id: UUID = UUID()
    public enum GestureType {
      case doubleTap
    }
    let gestureType: GestureType
    let action: (_ window: NSWindow) -> Void

    public static func doubleTapZoom(
      action: @MainActor @escaping (_ window: NSWindow) -> Void = { w in
        if w.isZoomed {
          w.setIsZoomed(false)
        } else {
          w.setIsZoomed(true)
        }
      }
    )
      -> WindowGestureConfiguration
    {
      WindowGestureConfiguration(
        gestureType: .doubleTap,
        action: { w in Task { @MainActor in action(w) } }
      )
    }
  }
}

extension NeoBrutal {
  public struct WindowButtonConfiguration: Identifiable {
    public enum ButtonState {
      case inactive
      case hovered
      case active
    }
    public let id: UUID = UUID()
    let icon: Image
    let color: (ButtonState, NSWindow?) -> Color
    let accessibilityLabel: String
    let action: (_ window: NSWindow) -> Void

    public static func close(
      action: @MainActor @escaping (_ window: NSWindow) -> Void = {
        w in w.windowController?.close()
      }
    )
      -> WindowButtonConfiguration
    {
      WindowButtonConfiguration(
        icon: Image(systemName: "xmark"),
        color: { state, window in
          switch state {
          case .inactive:
            Color.red
          case .hovered:
            Color.red.exposure(adjustment: 5)
          case .active:
            Color.red.mix(with: .black, by: 0.5).exposure(adjustment: 5)
          }
        },
        accessibilityLabel: "Close Window",
        action: { w in Task { @MainActor in action(w) } }
      )
    }

    public static func minimize(
      action: @MainActor @escaping (_ window: NSWindow) -> Void = {
        w in w.miniaturize(nil)
      }
    )
      -> WindowButtonConfiguration
    {
      WindowButtonConfiguration(
        icon: Image(systemName: "minus"),
        color: { state, window in
          switch state {
          case .inactive:
            Color.yellow
          case .hovered:
            Color.yellow.exposure(adjustment: 5)
          case .active:
            Color.yellow.mix(with: .black, by: 0.5).exposure(adjustment: 5)
          }
        },
        accessibilityLabel: "Minimize Window",
        action: { w in Task { @MainActor in action(w) } }
      )
    }
    public static func zoom(
      action: @MainActor @escaping (_ window: NSWindow) -> Void = { w in
        if w.isZoomed {
          w.setIsZoomed(false)
        } else {
          w.setIsZoomed(true)
        }
      }
    )
      -> WindowButtonConfiguration
    {
      WindowButtonConfiguration(
        icon: Image(systemName: "chevron.up.chevron.down"),
        color: { state, window in
          switch state {
          case .inactive:
            Color.green
          case .hovered:
            Color.green.exposure(adjustment: 5)
          case .active:
            Color.green.mix(with: .black, by: 0.5).exposure(adjustment: 5)
          }
        },
        accessibilityLabel: "Zoom Window",
        action: { w in Task { @MainActor in action(w) } }
      )
    }
    public static func pin(
      action: @MainActor @escaping (_ window: NSWindow) -> Void = { w in
        w.level = w.level == .normal ? .floating : .normal
      }
    )
      -> WindowButtonConfiguration
    {
      WindowButtonConfiguration(
        icon: Image(systemName: "square.on.square"),
        color: { state, window in
          switch state {
          case .inactive:
            Color.blue
          case .hovered:
            Color.blue.exposure(adjustment: 5)
          case .active:
            Color.blue.mix(with: .black, by: 0.5).exposure(adjustment: 5)
          }
        },
        accessibilityLabel: "Pin Window",
        action: { w in Task { @MainActor in action(w) } }
      )
    }

    init(
      icon: Image,
      color: @escaping (ButtonState, NSWindow?) -> Color,
      accessibilityLabel: String,
      action: @escaping (_ window: NSWindow) -> Void
    ) {
      self.icon = icon
      self.color = color
      self.accessibilityLabel = accessibilityLabel
      self.action = action
    }
  }
}

extension [NeoBrutal.WindowButtonConfiguration] {
  @MainActor
  public static var defaultButtons: Self {

    [
      .close(),
      .minimize(),
      .zoom(),
    ]
  }

  @MainActor
  public static var pinButton: Self {
    [
      .pin()
    ]
  }
}
extension [NeoBrutal.WindowGestureConfiguration] {
  @MainActor
  public static var defaultGestures: Self {

    [
      .doubleTapZoom()
    ]
  }
}
