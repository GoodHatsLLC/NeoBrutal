import SwiftUI

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

        public static func doubleTap(action: @escaping (_ window: NSWindow) -> Void)
            -> WindowGestureConfiguration
        {
            WindowGestureConfiguration(
                gestureType: .doubleTap,
                action: action
            )
        }
    }

    public struct WindowChromeButtonConfiguration: Identifiable {
        public let id: UUID = UUID()
        public let icon: Image
        public let color: Color
        public let accessibilityLabel: String
        public let action: (_ window: NSWindow) -> Void

        public static func close(action: @escaping (_ window: NSWindow) -> Void)
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "xmark"),
                color: Color.red,
                accessibilityLabel: "Close Window",
                action: action
            )
        }

        public static func minimize(action: @escaping (_ window: NSWindow) -> Void)
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "minus"),
                color: Color.yellow,
                accessibilityLabel: "Minimize Window",
                action: action
            )
        }
        public static func zoom(action: @escaping (_ window: NSWindow) -> Void)
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "arrow.up.left.and.arrow.down.right"),
                color: Color.green,
                accessibilityLabel: "Zoom Window",
                action: action
            )
        }
        public static func pin(action: @escaping (_ window: NSWindow) -> Void)
            -> WindowChromeButtonConfiguration
        {
            WindowChromeButtonConfiguration(
                icon: Image(systemName: "square.on.square"),
                color: Color.cyan,
                accessibilityLabel: "Pin Window",
                action: action
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
                WindowChromeButtonConfiguration.close(action: { $0.performClose(nil) }),
                WindowChromeButtonConfiguration.minimize { $0.miniaturize(nil) },
                WindowChromeButtonConfiguration.zoom { $0.performZoom(nil) },
            ]
        }
    }
    extension [WindowGestureConfiguration] {
        @MainActor
        public static var defaultGestures: [WindowGestureConfiguration] {

            [
                WindowGestureConfiguration.doubleTap { $0.toggleFullScreen(nil) }
            ]
        }
    }

    public struct NeoBrutalistWindowChrome<Accessory: View>: View {
        @Environment(\.neoBrutalistTheme) private var theme

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
                .background(background)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
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

        private var background: some View {
            Rectangle()
                .fill(theme.surface.primary.color)
                .overlay(
                    Rectangle()
                        .stroke(
                            theme.surface.secondary.color.opacity(0.75),
                            lineWidth: theme.borderWidth)
                )
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(theme.accent.primary.color)
                        .frame(height: accentHeight)
                }
                .ignoresSafeArea(edges: [.top, .horizontal])
        }

        private var chromeContent: some View {
            HStack(spacing: 16) {
                WindowControls(theme: theme, window: window, windowButtons: windowButtons)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(theme.typography.titleFont)
                        .foregroundColor(theme.textPrimary.color)
                        .lineLimit(1)

                    if let subtitle, !subtitle.isEmpty {
                        Text(subtitle.uppercased())
                            .font(theme.typography.monoFont)
                            .foregroundColor(theme.textMuted.color)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                Capsule(style: .continuous)
                                    .fill(theme.surface.secondary.color.opacity(0.7))
                                    .overlay(
                                        Capsule(style: .continuous)
                                            .stroke(
                                                theme.surface.highlight.color.opacity(0.65),
                                                lineWidth: max(theme.borderWidth * 0.8, 1))
                                    )
                            )
                    }
                }
                Spacer()
                accessory
            }
            .padding(.horizontal, 10)
            .padding(.top, 8)
            .padding(.bottom, 10)
        }

        private var accentHeight: CGFloat {
            max(theme.borderWidth * 3, 8)
        }

        private func configureWindow(_ window: NSWindow) {
            let requiredMask: NSWindow.StyleMask = [
                .titled, .closable, .miniaturizable, .resizable, .fullSizeContentView,
            ]

            if !window.styleMask.contains(requiredMask) {
                window.styleMask.formUnion(requiredMask)
            }

            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.isMovableByWindowBackground = true
            window.backgroundColor = .clear

            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true

            if !window.isKeyWindow, window.canBecomeKey {
                window.makeKey()
            }
        }
    }

    struct WindowControls: View {
        var theme: NeoBrutalistTheme
        let window: NSWindow?
        let windowButtons: [WindowChromeButtonConfiguration]
        @State private var hover: Bool = false
        var body: some View {
            HStack(spacing: 8) {
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
            _ control: WindowChromeButtonConfiguration, hover: Bool
        )
            -> some View
        {

            WithState(initialState: false) { $down in
                Button {
                    if let window {
                        control.action(window)
                    }
                } label: {
                    Circle()
                        .fill(control.color)
                        .stroke(
                            control.color.mix(with: .black, by: 0.7).opacity(0.5),
                            lineWidth: max(theme.borderWidth * 0.6, 1)
                        )
                        .frame(
                            width: theme.windowButtonSize.width,
                            height: theme.windowButtonSize.height
                        )
                        .overlay {
                            Circle()
                                .inset(
                                    by: max(
                                        1,
                                        min(
                                            theme.windowButtonSize.width,
                                            theme.windowButtonSize.height)
                                            * 0.1)
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            down ? .black.opacity(0.3) : .white.opacity(0.3),
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
                            .opacity(
                                hover ? 0.7 : 0
                            ).padding(
                                max(
                                    2,
                                    min(theme.windowButtonSize.width, theme.windowButtonSize.height)
                                        * 0.22)
                            )
                        )
                        .bold()
                        .contentShape(Circle())
                        .shadow(color: Color.black.opacity(0.08), radius: 1.5, x: 0, y: 1)
                        .compositingGroup()
                }
                .buttonStyle(NoStyle())
                .accessibilityLabel(control.accessibilityLabel)
                .onTouchUpInside(downInside: $down)
                .disabled(window == nil)
            }
        }
    }

    struct NeoBrutalistWindowResizeHandle: View {
        @Environment(\.neoBrutalistTheme) private var theme

        @State private var window: NSWindow?
        @State private var initialFrame: NSRect?
        @State private var isDragging = false
        @State private var isHovering = false
        @State private var cursorPushed = false

        private let handleDimension: CGFloat = 28

        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
                    .shadow(
                        color: Color.black.opacity(0.12), radius: isHovering || isDragging ? 4 : 2,
                        x: 0, y: 2)

                ResizeGlyph()
                    .stroke(indicatorColor, lineWidth: 1.6)
                    .frame(width: handleDimension * 0.42, height: handleDimension * 0.42)
                    .padding(.bottom, 5)
                    .padding(.trailing, 5)
            }
            .frame(width: handleDimension, height: handleDimension)
            .padding(4)
            .contentShape(Rectangle())
            .opacity(isHandleAvailable ? 1 : 0)
            .allowsHitTesting(isHandleAvailable)
            .animation(.easeOut(duration: 0.16), value: isHovering)
            .animation(.easeOut(duration: 0.16), value: isDragging)
            .onHover { hovering in
                isHovering = hovering
                updateCursor(hovering: hovering)
            }
            .gesture(dragGesture)
            .background(
                WindowReader { newWindow in
                    window = newWindow
                }
            )
            .onDisappear {
                if cursorPushed {
                    NSCursor.pop()
                    cursorPushed = false
                }
            }
            .accessibilityLabel("Resize Window")
        }

        private var dragGesture: some Gesture {
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    guard isHandleAvailable else { return }
                    if initialFrame == nil {
                        initialFrame = window?.frame
                    }
                    isDragging = true
                    updateWindowFrame(with: value)
                }
                .onEnded { _ in
                    isDragging = false
                    initialFrame = nil
                }
        }

        private var isHandleAvailable: Bool {
            guard let window, window.styleMask.contains(.resizable) else { return false }
            return true
        }

        private var backgroundColor: Color {
            if isDragging {
                return theme.surface.secondary.color.opacity(0.85)
            }
            if isHovering {
                return theme.surface.secondary.color.opacity(0.75)
            }
            return theme.surface.secondary.color.opacity(0.55)
        }

        private var borderColor: Color {
            theme.surface.highlight.color.opacity(0.9)
        }

        private var borderWidth: CGFloat {
            max(theme.borderWidth * 0.9, 1.2)
        }

        private var indicatorColor: Color {
            if isDragging {
                return theme.textPrimary.color.opacity(0.95)
            }
            if isHovering {
                return theme.textPrimary.color.opacity(0.75)
            }
            return theme.textMuted.color.opacity(0.8)
        }

        private func updateWindowFrame(with value: DragGesture.Value) {
            guard let window, let startFrame = initialFrame else { return }

            var newFrame = startFrame

            let minWidth = resolvedMinimumWidth(for: window)
            let maxWidth = resolvedMaximumWidth(for: window)

            var proposedWidth = startFrame.size.width + value.translation.width
            proposedWidth = clamp(proposedWidth, minWidth, maxWidth)
            newFrame.size.width = proposedWidth

            let minHeight = resolvedMinimumHeight(for: window)
            let maxHeight = resolvedMaximumHeight(for: window)

            let proposedHeight = startFrame.size.height + value.translation.height
            let clampedHeight = clamp(proposedHeight, minHeight, maxHeight)
            let top = startFrame.maxY
            newFrame.size.height = clampedHeight
            newFrame.origin.y = top - clampedHeight

            if newFrame != window.frame {
                window.setFrame(newFrame, display: true, animate: false)
            }
        }

        private func updateCursor(hovering: Bool) {
            #if os(macOS)
                if hovering && !cursorPushed {
                    NSCursor.closedHand.push()
                    cursorPushed = true
                } else if !hovering && cursorPushed {
                    NSCursor.pop()
                    cursorPushed = false
                }
            #endif
        }

        private func clamp(_ value: CGFloat, _ minValue: CGFloat, _ maxValue: CGFloat) -> CGFloat {
            min(max(value, minValue), maxValue)
        }

        private func resolvedMinimumWidth(for window: NSWindow) -> CGFloat {
            let fallback: CGFloat = 80
            let candidates = [window.contentMinSize.width, window.minSize.width, fallback].filter {
                $0 > 0
            }
            return candidates.max() ?? fallback
        }

        private func resolvedMinimumHeight(for window: NSWindow) -> CGFloat {
            let fallback: CGFloat = 80
            let candidates = [window.contentMinSize.height, window.minSize.height, fallback].filter
            { $0 > 0 }
            return candidates.max() ?? fallback
        }

        private func resolvedMaximumWidth(for window: NSWindow) -> CGFloat {
            let candidates = [window.contentMaxSize.width, window.maxSize.width].filter {
                $0 > 0 && $0 < .greatestFiniteMagnitude
            }
            return candidates.min() ?? .greatestFiniteMagnitude
        }

        private func resolvedMaximumHeight(for window: NSWindow) -> CGFloat {
            let candidates = [window.contentMaxSize.height, window.maxSize.height].filter {
                $0 > 0 && $0 < .greatestFiniteMagnitude
            }
            return candidates.min() ?? .greatestFiniteMagnitude
        }

        private struct ResizeGlyph: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()

                let spacing = rect.width / 3

                path.move(to: CGPoint(x: rect.maxX, y: rect.minY + spacing))
                path.addLine(to: CGPoint(x: rect.minX + spacing, y: rect.maxY))

                path.move(to: CGPoint(x: rect.maxX, y: rect.minY + spacing * 2))
                path.addLine(to: CGPoint(x: rect.minX + spacing * 2, y: rect.maxY))

                path.move(to: CGPoint(x: rect.maxX - spacing, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - spacing))

                return path
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
    public func readingSize(into binding: Binding<CGSize>) -> some View {
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
