import NeoBrutal
import SwiftUI

@main
struct NeoBrutalDemoApp: App {
  @State var isDarkMode: Bool = false
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
      Toggle(isDarkMode ? "🌘" : "☀️", isOn: $isDarkMode)
        .toggleStyle(.neoBrutal)
    }
    .environment(\.colorScheme, isDarkMode ? .dark : .light)
    .environment(\.neoBrutalTheme, selectedTheme)
  }
}
