import AppKit
import SwiftUI

struct WindowReader: NSViewRepresentable {
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
