import NeoBrutal
import SwiftUI

/// Configuration for rendering snapshots
struct SnapshotConfig: Sendable {
  let size: CGSize
  let scale: CGFloat
  let theme: NeoBrutalTheme
  let colorScheme: ColorScheme

  init(
    size: CGSize,
    scale: CGFloat,
    theme: NeoBrutalTheme,
    colorScheme: ColorScheme = .light
  ) {
    self.size = size
    self.scale = scale
    self.theme = theme
    self.colorScheme = colorScheme
  }

  static let standard = SnapshotConfig(
    size: CGSize(width: 400, height: 300),
    scale: 2.0,
    theme: .bubblegum,
    colorScheme: .light
  )

  static let compact = SnapshotConfig(
    size: CGSize(width: 300, height: 200),
    scale: 2.0,
    theme: .bubblegum,
    colorScheme: .light
  )

  static let wide = SnapshotConfig(
    size: CGSize(width: 600, height: 300),
    scale: 2.0,
    theme: .bubblegum,
    colorScheme: .light
  )

  func with(theme: NeoBrutalTheme, colorScheme: ColorScheme) -> SnapshotConfig {
    SnapshotConfig(
      size: size,
      scale: scale,
      theme: theme,
      colorScheme: colorScheme
    )
  }
}

/// Renders SwiftUI views to images for snapshot testing
struct SnapshotRenderer {
  /// Renders a view to a CGImage
  @MainActor
  static func render<Content: View>(
    _ content: Content,
    config: SnapshotConfig
  ) -> CGImage? {
    let renderer = ImageRenderer(
      content:
        content
        .frame(width: config.size.width, height: config.size.height)
        .environment(\.colorScheme, config.colorScheme)
        .neoBrutalTheme(config.theme)
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

    // Create theme/color scheme-specific subdirectory
    let themeDir = outputDirectory.appendingPathComponent(
      config.theme.name.isEmpty ? "default" : config.theme.name)
    let colorSchemeDir = themeDir.appendingPathComponent(config.colorScheme.snapshotDirectoryName)
    try FileManager.default.createDirectory(at: colorSchemeDir, withIntermediateDirectories: true)

    let filename = "\(name)@\(Int(config.scale))x.png"
    let fileURL = colorSchemeDir.appendingPathComponent(filename)

    try savePNG(image, to: fileURL)

    print(
      "✅ Saved snapshot: \(themeDir.lastPathComponent)/\(config.colorScheme.snapshotDirectoryName)/\(filename)"
    )
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

extension ColorScheme {
  fileprivate var snapshotDirectoryName: String {
    switch self {
    case .dark:
      return "dark"
    default:
      return "light"
    }
  }
}
