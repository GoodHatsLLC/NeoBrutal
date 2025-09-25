import NeoBrutalistUI
import SwiftUI

@main
struct NeoBrutalistDemoApp: App {
    @State private var selectedTheme: NeoBrutalistTheme = .bubblegum
    @State private var isPinned: Bool = false
    var body: some Scene {
        NeoBrutalistWindowGroup(
            id: "main",
            buttons: .defaultButtons + [
                .pin { window in
                    isPinned.toggle()
                }
            ],
            title: "NeoBrutalist"
        ) {
            DemoRootView(selectedTheme: $selectedTheme)
        }
        .windowLevel(isPinned ? .floating : .normal)
        .environment(\.neoBrutalistTheme, selectedTheme)
    }
}
