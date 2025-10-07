import Foundation
import SwiftUI
import NeoBrutalistUI

@main
struct SnapshotApp {
    static func main() async {
        print("🎨 NeoBrutalist UI Snapshot Generator")
        print("=====================================\n")

        // Setup output directory
        let outputPath = ProcessInfo.processInfo.environment["SNAPSHOT_OUTPUT"]
            ?? FileManager.default.currentDirectoryPath + "/Snapshots"

        let outputURL = URL(fileURLWithPath: outputPath)

        do {
            try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)
            print("📁 Output directory: \(outputURL.path)\n")
        } catch {
            print("❌ Failed to create output directory: \(error)")
            exit(1)
        }

        // Get themes to test
        let themes = SnapshotApp.themesToTest()
        print("🎨 Testing \(themes.count) theme(s): \(themes.map { $0.name }.joined(separator: ", "))\n")

        // Get test cases
        let testCases = ComponentTestCases.all
        print("🧪 Found \(testCases.count) test case(s)\n")

        // Run snapshots
        await MainActor.run {
            var successCount = 0
            var failureCount = 0

            for theme in themes {
                print("Theme: \(theme.name)")
                print(String(repeating: "-", count: 40))

                for testCase in testCases {
                    let config = SnapshotConfig(
                        size: testCase.config.size,
                        scale: testCase.config.scale,
                        theme: theme
                    )

                    do {
                        try SnapshotRenderer.snapshot(
                            testCase.view,
                            name: testCase.name,
                            config: config,
                            outputDirectory: outputURL
                        )
                        successCount += 1
                    } catch {
                        print("❌ Failed to snapshot \(testCase.name): \(error)")
                        failureCount += 1
                    }
                }
                print()
            }

            // Summary
            print("\n" + String(repeating: "=", count: 40))
            print("📊 Summary")
            print(String(repeating: "=", count: 40))
            print("✅ Successful: \(successCount)")
            if failureCount > 0 {
                print("❌ Failed: \(failureCount)")
            }
            print("\n📁 Snapshots saved to: \(outputURL.path)")

            exit(failureCount > 0 ? 1 : 0)
        }

        // Keep process alive briefly for cleanup
        try? await Task.sleep(for: .milliseconds(100))
    }

    /// Determines which themes to test based on environment variables
    static func themesToTest() -> [NeoBrutalistTheme] {
        if let themeNames = ProcessInfo.processInfo.environment["SNAPSHOT_THEMES"]?.split(separator: ",") {
            return themeNames.compactMap { name in
                themeByName(String(name).trimmingCharacters(in: .whitespaces))
            }
        }

        // Default: test all themes
        return [
            NeoBrutalistTheme.bubblegum,
            NeoBrutalistTheme.daybreakPlaza,
            NeoBrutalistTheme.nocturneVolt,
            NeoBrutalistTheme.ultravioletCargo,
            NeoBrutalistTheme.desert,
            NeoBrutalistTheme.jungle,
            NeoBrutalistTheme.crimsonFury
        ]
    }

    /// Gets a theme by name
    static func themeByName(_ name: String) -> NeoBrutalistTheme? {
        switch name.lowercased() {
        case "bubblegum": return .bubblegum
        case "daybreakplaza", "daybreak": return .daybreakPlaza
        case "nocturnevelt", "nocturne": return .nocturneVolt
        case "ultravioletcargo", "ultraviolet": return .ultravioletCargo
        case "desert": return .desert
        case "jungle": return .jungle
        case "crimsonfury", "crimson": return .crimsonFury
        default: return nil
        }
    }
}
