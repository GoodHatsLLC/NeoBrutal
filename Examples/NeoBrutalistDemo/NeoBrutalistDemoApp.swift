import NeoBrutalistUI
import SwiftUI

@main
struct NeoBrutalistDemoApp: App {
  @State private var selectedTheme: NeoBrutalistTheme = .bubblegum
  var body: some Scene {
    NeoBrutalistWindowGroup(
      id: "main",
      title: Text("NeoBrutalist"),
      buttons: .defaultButtons,
      gestures: .defaultGestures,
    ) {
      DemoRootView(selectedTheme: $selectedTheme)
    } overlay: {

    } accessory: {

    }
    .environment(\.neoBrutalistTheme, selectedTheme)
  }
}
