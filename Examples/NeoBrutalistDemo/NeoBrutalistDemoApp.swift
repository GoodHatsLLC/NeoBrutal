import NeoBrutalistUI
import SwiftUI

@main
struct NeoBrutalistDemoApp: App {
    @State private var selectedTheme: NeoBrutalistTheme = .bubblegum
    var body: some Scene {
        NeoBrutalistWindowGroup(
            id: "main",
            buttons: .defaultButtons,
            gestures: .defaultGestures,
            title: "NeoBrutalist"
        ) {
            DemoRootView(selectedTheme: $selectedTheme)
        }
        .environment(\.neoBrutalistTheme, selectedTheme)
    }
}
