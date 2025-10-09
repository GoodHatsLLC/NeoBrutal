import AppKit
import Foundation
import NeoBrutalistUI
import SwiftUI

// Simple window display app - just shows a window and waits
@main
struct NeoBrutalistWindowSnapshotsApp: App {
  @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

  var body: some Scene {
    WindowGroup {
      EmptyView()
        .frame(width: 0, height: 0)
        .hidden()
    }
    .windowStyle(.hiddenTitleBar)
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  var window: NSWindow?

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Parse command line arguments
    let args = CommandLine.arguments
    guard args.count >= 4 else {
      print(
        "Usage: NeoBrutalistWindowSnapshots <theme> <window-type> <title> [subtitle] [--timeout=seconds]"
      )
      NSApplication.shared.terminate(nil)
      return
    }

    let themeName = args[1]
    let windowType = args[2]
    let title = args[3]
    let subtitle = args.count > 4 && !args[4].hasPrefix("--") ? args[4] : ""

    // Check for timeout option
    var timeout: TimeInterval = 10.0  // Default 10 seconds
    for arg in args {
      if arg.hasPrefix("--timeout=") {
        if let value = Double(arg.replacingOccurrences(of: "--timeout=", with: "")) {
          timeout = value
        }
      }
    }

    // Get theme
    guard let theme = NeoBrutalistTheme.allThemes.first(where: { $0.name == themeName }) else {
      print("Unknown theme: \(themeName)")
      NSApplication.shared.terminate(nil)
      return
    }

    // Create and show window
    Task { @MainActor in
      self.window = createWindow(type: windowType, title: title, subtitle: subtitle, theme: theme)
      self.window?.makeKeyAndOrderFront(nil)
      self.window?.orderFrontRegardless()

      print("Window shown, waiting \(timeout) seconds...")

      // Wait for timeout
      try? await Task.sleep(for: .seconds(timeout))
      print("Timeout reached, exiting...")
      NSApplication.shared.terminate(nil)
    }
  }

  @MainActor
  func createWindow(type: String, title: String, subtitle: String, theme: NeoBrutalistTheme)
    -> NSWindow
  {
    let content: AnyView

    switch type {
    case "simple":
      content = AnyView(
        Text("Simple Window")
          .font(.title)
          .frame(width: 400, height: 300)
      )
    case "with-content":
      content = AnyView(
        VStack(spacing: 20) {
          Text("Window with Content")
            .font(.title)

          NeoBrutalistCard(title: "Card in Window") {
            Text("This is a card inside a window")
          }

          HStack {
            NeoBrutalistButton {
              print("Action")
            } label: {
              Text("Action")
            }

            NeoBrutalistButton {
              print("Cancel")
            } label: {
              Text("Cancel")
            }
          }
        }
        .padding()
        .frame(width: 500, height: 400)
      )
    case "with-subtitle":
      content = AnyView(
        VStack {
          Text("Window with Subtitle")
            .font(.title)
          Text("This window has a subtitle badge")
            .foregroundStyle(.secondary)
        }
        .frame(width: 450, height: 250)
        .padding()
      )
    default:
      content = AnyView(
        Text("Unknown window type")
          .frame(width: 400, height: 300)
      )
    }

    return createNeoBrutalistWindow(
      title: title,
      subtitle: subtitle,
      theme: theme,
      content: content
    )
  }

  @MainActor
  func createNeoBrutalistWindow<Content: View>(
    title: String,
    subtitle: String,
    theme: NeoBrutalistTheme,
    content: Content
  ) -> NSWindow {
    let variant = theme.variant(for: .light)

    let contentView = VStack(spacing: 0) {
      NeoBrutalistWindowChrome(
        buttons: .defaultButtons,
        gestures: .defaultGestures,
        title: title,
        subtitle: subtitle.isEmpty ? nil : subtitle
      )
      content
    }
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: variant.windowRadius, style: .continuous))
    .overlay {
      RoundedRectangle(cornerRadius: variant.windowRadius, style: .continuous)
        .strokeBorder(.primary, lineWidth: variant.windowBorder)
    }
    .offset(x: -variant.windowShadowOffset.width / 2.0, y: -variant.windowShadowOffset.height / 2.0)
    .background {
      RoundedRectangle(cornerRadius: variant.windowRadius)
        .fill(.primary.opacity(variant.shadowOpacity))
        .offset(
          x: variant.windowShadowOffset.width / 2.0, y: variant.windowShadowOffset.height / 2.0)
    }
    .padding(.horizontal, variant.windowShadowOffset.width / 2.0)
    .padding(.vertical, variant.windowShadowOffset.height / 2.0)
    .neoBrutalistTheme(theme)
    .preferredColorScheme(.light)

    let hostingController = NSHostingController(rootView: contentView)

    let window = NSWindow(contentViewController: hostingController)
    window.styleMask = [
      NSWindow.StyleMask.closable, .miniaturizable, .resizable, .fullSizeContentView,
    ]
    window.titleVisibility = NSWindow.TitleVisibility.hidden
    window.titlebarAppearsTransparent = true
    window.backgroundColor = NSColor.clear
    window.isMovableByWindowBackground = false
    window.isOpaque = false
    window.hasShadow = false

    // Hide standard window buttons
    window.standardWindowButton(NSWindow.ButtonType.closeButton)?.isHidden = true
    window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)?.isHidden = true
    window.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isHidden = true

    return window
  }

}

// Extension to get all themes
extension NeoBrutalistTheme {
  static var allThemes: [NeoBrutalistTheme] {
    [
      .bubblegum,
      .daybreakPlaza,
      .nocturneVolt,
      .ultravioletCargo,
      .desert,
      .jungle,
      .crimsonFury,
    ]
  }
}
