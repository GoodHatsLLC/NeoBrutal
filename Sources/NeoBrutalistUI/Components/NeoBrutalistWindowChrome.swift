
#if os(macOS)
    import SwiftUI
    import AppKit

    public struct WindowGestureConfiguration: Identifiable {
        public let id: UUID = UUID()
        public enum GestureType {
            case doubleTap
        }
        public let gestureType: GestureType
        public let action: (_ window: NSWindow) -> Void

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

    public struct WindowChromeButtonConfiguration: Identifiable {
        public let id: UUID = UUID()
        public let icon: Image
        public let color: Color
        public let accessibilityLabel: String
        public let action: (_ window: NSWindow) -> Void

        public static func close(
            action: @MainActor @escaping (_ window: NSWindow) -> Void = {
                w in w.windowController?.close()
            }
        )
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "xmark"),
                color: Color.red,
                accessibilityLabel: "Close Window",
                action: { w in Task { @MainActor in action(w) } }
            )
        }

        public static func minimize(
            action: @MainActor @escaping (_ window: NSWindow) -> Void = {
                w in w.miniaturize(nil)
            }
        )
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "minus"),
                color: Color.yellow,
                accessibilityLabel: "Minimize Window",
                action:  { w in Task { @MainActor in action(w) } }
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
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "chevron.up.chevron.down"),
                color: Color.green,
                accessibilityLabel: "Zoom Window",
                action:  { w in Task { @MainActor in action(w) } }
            )
        }
        public static func pin(
            action: @MainActor @escaping (_ window: NSWindow) -> Void = { w in
                w.level = w.level == .normal ? .floating : .normal
            }
        )
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "square.on.square"),
                color: Color.blue,
                accessibilityLabel: "Pin Window",
                action:  { w in Task { @MainActor in action(w) } }
            )
        }

        public init(
            icon: Image,
            color: Color,
            accessibilityLabel: String,
            action: @escaping (_ window: NSWindow) -> Void
        ) {
            self.icon = icon
            self.color = color
            self.accessibilityLabel = accessibilityLabel
            self.action = action
        }
    }

    extension [WindowChromeButtonConfiguration] {
        @MainActor
        public static var defaultButtons: [WindowChromeButtonConfiguration] {

            [
                WindowChromeButtonConfiguration.close(),
                WindowChromeButtonConfiguration.minimize(),
                WindowChromeButtonConfiguration.zoom(),
                WindowChromeButtonConfiguration.pin()
            ]
        }
    }
    extension [WindowGestureConfiguration] {
        @MainActor
        public static var defaultGestures: [WindowGestureConfiguration] {

            [
                WindowGestureConfiguration.doubleTapZoom()
            ]
        }
    }

    public struct NeoBrutalistWindowChrome<Accessory: View>: View {
        @Environment(\.neoBrutalistTheme) private var theme
        @Environment(\.colorScheme) private var colorScheme

        private var themeVariant: NeoBrutalistTheme.Variant {
            theme.variant(for: colorScheme)
        }

        private let title: String
        private let subtitle: String?
        private let accessory: Accessory
        private let windowButtons: [WindowChromeButtonConfiguration]
        private let windowGestures: [WindowGestureConfiguration]

        @State private var window: NSWindow?

        public init(
            buttons: [WindowChromeButtonConfiguration] = .defaultButtons,
            gestures: [WindowGestureConfiguration] = .defaultGestures,
            title: String,
            subtitle: String? = nil,
            @ViewBuilder accessory: () -> Accessory
        ) {
            self.title = title
            self.subtitle = subtitle
            self.accessory = accessory()
            self.windowButtons = buttons
            self.windowGestures = gestures
        }
        public init(
            buttons: [WindowChromeButtonConfiguration],
            gestures: [WindowGestureConfiguration],
            title: String,
            subtitle: String? = nil
        ) where Accessory == EmptyView {
            self.title = title
            self.subtitle = subtitle
            self.accessory = EmptyView()
            self.windowButtons = buttons
            self.windowGestures = gestures
        }

        public var body: some View {
            chromeContent
                .background(
                    WindowReader { newWindow in
                        guard let newWindow, window !== newWindow else { return }
                        window = newWindow
                        configureWindow(newWindow)
                    }
                )
                .task(id: theme) {
                    if let window {
                        configureWindow(window)
                    }
                }
        }
        private var chromeContent: some View {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Color.clear.frame(width: 16)
                            WindowControls(
                                theme: theme,
                                window: window,
                                windowButtons: windowButtons
                            )
                                .padding(.horizontal, themeVariant.borderWidth)
                            Color.clear
                                .frame(width: 16)
                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {
                                Text(title)
                                    .font(themeVariant.typography.titleFont)
                                    .foregroundColor(themeVariant.textPrimary.color)
                                    .lineLimit(1)
                                    .padding()

                                if let subtitle, !subtitle.isEmpty {
                                    Text(subtitle.uppercased())
                                        .font(themeVariant.typography.monoFont)
                                        .foregroundColor(themeVariant.textMuted.color)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(
                                            Capsule(style: .continuous)
                                                .fill(themeVariant.surface.secondary.color.opacity(0.7))
                                                .overlay(
                                                    Capsule(
                                                        style: .continuous
                                                    )
                                                        .stroke(
                                                            themeVariant.surface.highlight.color.opacity(
                                                                0.65
                                                            ),
                                                            lineWidth: max(
                                                                themeVariant.borderWidth * 0.8,
                                                                1
                                                            )
                                                        )
                                                )
                                        )
                                }
                            }
                            .fixedSize()
                            Spacer(minLength: 0)
                            Color.clear.frame(width: 16)
                            accessory.lineLimit(1)
                            Color.clear.frame(width: 16)
                        }
                        .background {
                            if themeVariant.noiseOpacity > 0 {
                                Rectangle()
                                    .fill(NeoBrutalistNoise.paint())
                                    .opacity(themeVariant.noiseOpacity)
                                    .blendMode(.overlay)
                            }
                        }
                        Rectangle()
                            .fill(themeVariant.accent.primary.color)
                            .frame(height: accentHeight)
                        Rectangle()
                            .fill(.primary.opacity(themeVariant.shadowOpacity))
                            .frame(height: accentHeight)
                    }
                    .background {
                        Rectangle()
                            .fill(themeVariant.surface.primary.color)
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
                            .simultaneousGesture(WindowDragGesture())
                    }
                .ignoresSafeArea()
        }

        private var accentHeight: CGFloat {
            max(themeVariant.borderWidth * 3, 8)
        }

        private func configureWindow(_ window: NSWindow) {
            let requiredMask: NSWindow.StyleMask = [
                .closable,
                .miniaturizable,
                .resizable,
                .fullSizeContentView,
            ]

            if !window.styleMask.contains(requiredMask) {
                window.styleMask.formUnion(requiredMask)
            }

            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
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

    struct WindowControls: View {
        var theme: NeoBrutalistTheme
        let window: NSWindow?
        let windowButtons: [WindowChromeButtonConfiguration]
        @State private var hover: Bool = false
        @Environment(\.colorScheme) private var colorScheme

        private var themeVariant: NeoBrutalistTheme.Variant {
            theme.variant(for: colorScheme)
        }
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
            _ control: WindowChromeButtonConfiguration,
            hover: Bool
        )
            -> some View
        {

            WithState(initialState: (down: false, active: false)) { $s in
                Button {
                    if let window {
                        control.action(window)
                    }
                } label: {
                    Circle()
                        .fill(control.color.exposure(adjustment: s.active ? 5 : 0))
                        .stroke(
                            control.color.mix(with: .black, by: 0.7).opacity(0.5),
                            lineWidth: max(themeVariant.borderWidth * 0.6, 1)
                        )
                        .frame(
                            width: themeVariant.windowButtonSize.width,
                            height: themeVariant.windowButtonSize.height
                        )
                        .overlay {
                            Circle()
                                .inset(
                                    by: max(
                                        1,
                                        min(
                                            themeVariant.windowButtonSize.width,
                                            themeVariant.windowButtonSize.height)
                                            * 0.1)
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            s.down ? .black: .white.opacity(0.3),
                                            .clear,
                                        ], startPoint: .top,
                                        endPoint: .bottom)
                                )
                                .blendMode(.softLight)
                        }
                        .overlay(
                            control.icon.resizable(resizingMode: .tile).aspectRatio(
                                contentMode: .fit
                            )
                            .fontWeight(.black)
                            .opacity(
                                hover ? 0.7 : 0
                            ).padding(
                                max(
                                    2,
                                    min(themeVariant.windowButtonSize.width, themeVariant.windowButtonSize.height)
                                        * 0.22)
                            )
                        )
                        .contentShape(Circle())
                        .compositingGroup()
                }
                .buttonStyle(NoStyle())
                .accessibilityLabel(control.accessibilityLabel)
                .onTouchUpInside(downInside: $s.active)
                .disabled(window == nil)
            }
        }
    }

    private struct WindowReader: NSViewRepresentable {
        let handler: (NSWindow?) -> Void

        func makeNSView(context: Context) -> NSView {
            let view = NSView()
            view.isHidden = true
            DispatchQueue.main.async {
                handler(view.window)
            }
            return view
        }

        func updateNSView(_ nsView: NSView, context: Context) {
            DispatchQueue.main.async {
                handler(nsView.window)
            }
        }
    }
#endif

extension Color {
    public func exposure(adjustment amount: CGFloat) -> Color {
        if #available(macOS 26, iOS 26, watchOS 26, *) {
            self.exposureAdjust(amount)
        } else {
            self
        }
    }
}

struct WithState<V: View, S>: View {
    init(initialState: S, @ViewBuilder viewBuilder: @escaping (Binding<S>) -> V) {
        self.state = initialState
        self.viewBuilder = viewBuilder
    }
    @State private var state: S
    @ViewBuilder var viewBuilder: (Binding<S>) -> V
    var body: some View {
        viewBuilder($state)
    }
}

extension View {
    public func onTouchUpInside(
        downInside: Binding<Bool> = .constant(false),
        action: @escaping (_ time: TimeInterval) -> Void = { _ in }
    ) -> some View {
        self.modifier(TouchUpInsideModifier(touchingDownInside: downInside, action: action))
    }
}

struct TouchUpInsideModifier: ViewModifier {
    init(
        touchingDownInside: Binding<Bool>,
        action: @escaping (_ len: TimeInterval) -> Void
    ) {
        self.action = action
        _isTouchingDown = touchingDownInside
    }

    let action: (TimeInterval) -> Void
    @Binding var isTouchingDown: Bool
    @State var size: CGSize = .zero
    @State var isInside: Bool = false
    @State var start: Date?

    func body(content: Content) -> some View {
        content
            .readingSize(into: $size)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { touch in
                        isInside =
                            touch.translation.width >= 0 && touch.translation.height >= 0
                            && touch.translation.width < size.width
                            && touch.translation.height < size.height
                        if isInside {
                            start = start ?? Date.now
                        }
                    }
                    .onEnded { touch in
                        if isInside {
                            action(Date.now.timeIntervalSince(start ?? Date.now))
                        }
                        start = nil
                        isInside = false
                    }
            )
            .onChange(of: isInside) { _, new in
                isTouchingDown = new
            }
    }
}
extension View {
    func readingSize(into binding: Binding<CGSize>) -> some View {
        self
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .task(id: geo.size) {
                            binding.wrappedValue = geo.size
                        }
                }
            }
    }
}
struct NoStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
