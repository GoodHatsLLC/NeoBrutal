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
        } overlay: {

        } accessory: {
            NeoBrutalistButton(size: .prominent) {
          
            } label: {
                Label("Deploy Sequence", systemImage: "bolt.fill")
                    .labelStyle(.titleAndIcon)
            }
        }
        .environment(\.neoBrutalistTheme, selectedTheme)
    }
}
