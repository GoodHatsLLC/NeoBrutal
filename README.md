# NeoBrutalistUI

NeoBrutalistUI is a Swift Package that delivers a cross-platform (iOS + macOS) SwiftUI component library inspired by the bold, high-contrast shapes of neo-brutalism. It ships with a showcase app target (`NeoBrutalistDemo`) so you can preview the controls immediately.

## Highlights
- 🎨 Simplified themes with easy environment injection.
- 🧱 Opinionated components: buttons, cards, toggles, disclosure groups, badges, and background surfaces with brutalist texture.
- 🖥️ Single Swift package with library + demo executable target so the same code runs on iOS and macOS.
- ✅ Lightweight test coverage that validates palette math and theming helpers.

## Getting Started
1. Open the package in Xcode (`open Package.swift`) or run the demo:
   ```bash
   swift run NeoBrutalistDemo
   ```
2. Explore the `Examples/NeoBrutalistDemo` target for usage patterns and component composition.
3. Embed the library in your own app by adding the package dependency and importing `NeoBrutalistUI`.

## Targets
- `NeoBrutalistUI`: the SwiftUI component library.
- `NeoBrutalistDemo`: SwiftUI app target that showcases the components with live theme switching.
- `NeoBrutalistUITests`: unit tests focused on theme utilities.

## Development Notes
- Minimum platform versions: iOS 17, macOS 15.
- The build and tests can be executed with `swift build` and `swift test`.
- The demo uses only public API; anything you see there can be reused directly in your app.
