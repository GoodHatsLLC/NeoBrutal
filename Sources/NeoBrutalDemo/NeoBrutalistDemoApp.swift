import NeoBrutal
import SwiftUI

@main
struct NeoBrutalDemoApp: App {
  @State private var selectedTheme: NeoBrutalTheme = .bubblegum
  var body: some Scene {
    NeoBrutalWindowGroup(
      id: "main",
      title: Text("NeoBrutal"),
      buttons: .defaultButtons,
      gestures: .defaultGestures,
    ) {
      DemoRootView(selectedTheme: $selectedTheme)
    } overlay: {

    } accessory: {

    }
    .environment(\.neoBrutalTheme, selectedTheme)
  }
}
