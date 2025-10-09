
    import SwiftUI
    import AppKit

extension NeoBrutalist {
    @available(macOS 15.0, *)
    struct WindowChrome<Accessory: View>: View {
        @Environment(\.nb) private var nbTheme

        private let title: String
        private let subtitle: String?
        private let accessory: Accessory
        private let windowButtons: [NeoBrutalist.WindowButtonConfiguration]
        private let windowGestures: [NeoBrutalist.WindowGestureConfiguration]

        private let window: NSWindow?

        init(
            window: NSWindow?,
            buttons: [NeoBrutalist.WindowButtonConfiguration],
            gestures: [NeoBrutalist.WindowGestureConfiguration],
            title: String,
            subtitle: String? = nil,
            @ViewBuilder accessory: () -> Accessory
        ) {
            self.window = window
            self.title = title
            self.subtitle = subtitle
            self.accessory = accessory()
            self.windowButtons = buttons
            self.windowGestures = gestures
        }
        init(
            window: NSWindow?,
            buttons: [NeoBrutalist.WindowButtonConfiguration],
            gestures: [NeoBrutalist.WindowGestureConfiguration],
            title: String,
            subtitle: String? = nil
        ) where Accessory == EmptyView {
            self.window = window
            self.title = title
            self.subtitle = subtitle
            self.accessory = EmptyView()
            self.windowButtons = buttons
            self.windowGestures = gestures
        }

        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Color.clear.frame(width: 16)
                    WindowControls(
                        window: window,
                        windowButtons: windowButtons
                    )
                    .padding(.horizontal, nbTheme.borderWidth)
                    Color.clear
                        .frame(width: 16)
                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {
                        Text(title)
                            .font(nbTheme.typography.titleFont)
                            .foregroundColor(nbTheme.textPrimary.color)
                            .lineLimit(1)
                            .padding()
                            .allowsHitTesting(false)

                        if let subtitle, !subtitle.isEmpty {
                            Text(subtitle.uppercased())
                                .font(nbTheme.typography.monoFont)
                                .foregroundColor(nbTheme.textMuted.color)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(nbTheme.surface.secondary.color.opacity(0.7))
                                        .overlay(
                                            Capsule(
                                                style: .continuous
                                            )
                                            .stroke(
                                                nbTheme.surface.highlight.color.opacity(
                                                    0.65
                                                ),
                                                lineWidth: max(
                                                    nbTheme.borderWidth * 0.8,
                                                    1
                                                )
                                            )
                                        )
                                )
                                .padding(.vertical)
                                .allowsHitTesting(false)
                        }
                    }
                    .fixedSize()
                    Spacer(minLength: 0)
                    Color.clear.frame(width: 16)
                    accessory.lineLimit(1)
                    Color.clear.frame(width: 16)
                }
                .background {
                    if nbTheme.noiseOpacity > 0 {
                        Rectangle()
                            .fill(NeoBrutalist.noise())
                            .opacity(nbTheme.noiseOpacity)
                            .blendMode(.overlay)
                    }
                }
                Rectangle()
                    .fill(nbTheme.accent.primary.color)
                    .frame(height: accentHeight)
                Rectangle()
                    .fill(.primary.opacity(nbTheme.shadowOpacity))
                    .frame(height: accentHeight)
            }
            .background {
                Rectangle()
                    .fill(nbTheme.surface.primary.color)
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
                let buttonState: WindowButtonConfiguration.ButtonState = switch ( s.active, s.hovered) {
                case (true, _): .active
                case ( _, true): .hovered
                case ( _, _): .inactive
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
                                            s.active ? .black: .white.opacity(0.3),
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


extension NeoBrutalist {

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

extension NeoBrutalist {
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
                action:  { w in Task { @MainActor in action(w) } }
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
                action:  { w in Task { @MainActor in action(w) } }
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

extension [NeoBrutalist.WindowButtonConfiguration] {
        @MainActor
        public static var defaultButtons: Self {

            [
                .close(),
                .minimize(),
                .zoom()
            ]
        }

        @MainActor
        public static var pinButton: Self {
            [
                .pin()
            ]
        }
    }
extension [NeoBrutalist.WindowGestureConfiguration] {
        @MainActor
    public static var defaultGestures: Self {

            [
                .doubleTapZoom()
            ]
        }
    }

