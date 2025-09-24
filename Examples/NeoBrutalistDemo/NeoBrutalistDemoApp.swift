import SwiftUI
import NeoBrutalistUI

@main
struct NeoBrutalistDemoApp: App {
    @State private var selectedTheme: NeoBrutalistTheme = .bubblegum

    var body: some Scene {
        NeoBrutalistWindowGroup(id: "main", title: "NeoBrutalist") {
            DemoRootView(selectedTheme: $selectedTheme)
        }
        .environment(\.neoBrutalistTheme, selectedTheme)
    }
}

