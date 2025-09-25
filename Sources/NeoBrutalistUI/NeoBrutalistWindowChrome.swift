#if os(macOS)
    import SwiftUI
    import AppKit

    public struct NeoBrutalistWindowChrome: View {
        @Environment(\.neoBrutalistTheme) private var theme

        private let title: String
        private let subtitle: String?
        private let accessory: AnyView?

        @State private var window: NSWindow?

        public init(title: String, subtitle: String? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.accessory = nil
        }

        public init<Accessory: View>(
            title: String, subtitle: String? = nil, @ViewBuilder accessory: () -> Accessory
        ) {
            self.title = title
            self.subtitle = subtitle
            self.accessory = AnyView(accessory())
        }

        public var body: some View {
            chromeContent
                .background(background)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture(count: 2) {
                    window?.performZoom(nil)
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
                controls
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
                if let accessory {
                    accessory
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 14)
        }

        private var accentHeight: CGFloat {
            max(theme.borderWidth * 3, 8)
        }

        private var controls: some View {
            WithState(initialState: false) { $hover in
                HStack(spacing: 12) {
                    controlButton(.close, hover: hover)
                    controlButton(.miniaturize, hover: hover)
                    controlButton(.zoom, hover: hover)
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
        }

        private func controlButton(_ control: WindowControl, hover: Bool) -> some View {

            Button {
                run(control)
            } label: {
                Circle()
                    .fill(control.fill(for: theme))
                    .frame(width: 18, height: 18)
                    .overlay(
                        Circle()
                            .stroke(
                                theme.surface.secondary.color.opacity(0.85),
                                lineWidth: max(theme.borderWidth * 0.6, 1))
                    )
                    .overlay(control.icon(for: theme).opacity(hover ? 1 : 0))
                    .shadow(color: Color.black.opacity(0.08), radius: 1.5, x: 0, y: 1)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(control.accessibilityLabel)
            .disabled(window == nil)
        }

        private func run(_ control: WindowControl) {
            guard let window else { return }
            switch control {
            case .close:
                window.performClose(nil)
            case .miniaturize:
                window.miniaturize(nil)
            case .zoom:
                window.performZoom(nil)
            }
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

    private enum WindowControl {
        case close
        case miniaturize
        case zoom

        func fill(for theme: NeoBrutalistTheme) -> Color {
            switch self {
            case .close:
                return .red
            case .miniaturize:
                return .yellow
            case .zoom:
                return .green
            }
        }

        func icon(for theme: NeoBrutalistTheme) -> some View {
            Image(systemName: symbolName)
                .font(.system(size: 8, weight: .heavy, design: .rounded))
                .foregroundColor(Color.black.opacity(0.9))
        }

        private var symbolName: String {
            switch self {
            case .close:
                return "xmark"
            case .miniaturize:
                return "minus"
            case .zoom:
                return "arrow.up.left.and.arrow.down.right"
            }
        }

        var accessibilityLabel: String {
            switch self {
            case .close:
                return "Close Window"
            case .miniaturize:
                return "Minimize Window"
            case .zoom:
                return "Zoom Window"
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

    extension ColorDescriptor {
        fileprivate var nsColor: NSColor {
            NSColor(calibratedRed: red, green: green, blue: blue, alpha: alpha)
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
