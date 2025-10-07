import SwiftUI
import NeoBrutalistUI

/// Configuration for rendering snapshots
struct SnapshotConfig: Sendable {
    let size: CGSize
    let scale: CGFloat
    let theme: NeoBrutalistTheme

    static let standard = SnapshotConfig(
        size: CGSize(width: 400, height: 300),
        scale: 2.0,
        theme: .bubblegum
    )

    static let compact = SnapshotConfig(
        size: CGSize(width: 300, height: 200),
        scale: 2.0,
        theme: .bubblegum
    )

    static let wide = SnapshotConfig(
        size: CGSize(width: 600, height: 300),
        scale: 2.0,
        theme: .bubblegum
    )
}

/// Renders SwiftUI views to images for snapshot testing
struct SnapshotRenderer {
    /// Renders a view to a CGImage
    @MainActor
    static func render<Content: View>(
        _ content: Content,
        config: SnapshotConfig
    ) -> CGImage? {
        let renderer = ImageRenderer(content: content
            .frame(width: config.size.width, height: config.size.height)
            .neoBrutalistTheme(config.theme)
        )

        renderer.scale = config.scale

        #if os(macOS)
        return renderer.cgImage
        #else
        return renderer.cgImage
        #endif
    }

    /// Saves a CGImage to a PNG file
    static func savePNG(_ image: CGImage, to url: URL) throws {
        #if os(macOS)
        let rep = NSBitmapImageRep(cgImage: image)
        guard let data = rep.representation(using: .png, properties: [:]) else {
            throw SnapshotError.failedToCreatePNG
        }
        try data.write(to: url)
        #else
        let uiImage = UIImage(cgImage: image)
        guard let data = uiImage.pngData() else {
            throw SnapshotError.failedToCreatePNG
        }
        try data.write(to: url)
        #endif
    }

    /// Renders a view and saves it to disk
    @MainActor
    static func snapshot<Content: View>(
        _ content: Content,
        name: String,
        config: SnapshotConfig = .standard,
        outputDirectory: URL
    ) throws {
        guard let image = render(content, config: config) else {
            throw SnapshotError.failedToRender
        }

        // Create theme-specific subdirectory
        let themeDir = outputDirectory.appendingPathComponent(config.theme.name.isEmpty ? "default" : config.theme.name)
        try FileManager.default.createDirectory(at: themeDir, withIntermediateDirectories: true)

        let filename = "\(name)@\(Int(config.scale))x.png"
        let fileURL = themeDir.appendingPathComponent(filename)

        try savePNG(image, to: fileURL)

        print("✅ Saved snapshot: \(themeDir.lastPathComponent)/\(filename)")
    }
}

enum SnapshotError: Error, LocalizedError {
    case failedToRender
    case failedToCreatePNG
    case failedToCreateDirectory

    var errorDescription: String? {
        switch self {
        case .failedToRender:
            return "Failed to render view to image"
        case .failedToCreatePNG:
            return "Failed to create PNG data"
        case .failedToCreateDirectory:
            return "Failed to create output directory"
        }
    }
}
