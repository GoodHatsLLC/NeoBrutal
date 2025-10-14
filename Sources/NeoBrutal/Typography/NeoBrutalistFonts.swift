import CoreText
import SwiftUI
import os

private struct NeoBrutalFontResource {
  let postScriptName: String
  let fileName: String
  let fileExtension: String
}

enum NeoBrutalFontRegistrar {
  private static let resources: [String: NeoBrutalFontResource] = [
    NeoBrutalFontResource(
      postScriptName: "Inter-Medium",
      fileName: "Inter-Medium",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Aspekta-300",
      fileName: "Aspekta-300",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Aspekta-500",
      fileName: "Aspekta-500",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Aspekta-700",
      fileName: "Aspekta-700",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "CabinetGrotesk-Regular",
      fileName: "CabinetGrotesk-Regular",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "CabinetGrotesk-Medium",
      fileName: "CabinetGrotesk-Medium",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "CabinetGrotesk-Bold",
      fileName: "CabinetGrotesk-Bold",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Light",
      fileName: "Zodiak-Light",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Thin",
      fileName: "Zodiak-Thin",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Regular",
      fileName: "Zodiak-Regular",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Bold",
      fileName: "Zodiak-Bold",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Extrabold",
      fileName: "Zodiak-Extrabold",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "Zodiak-Black",
      fileName: "Zodiak-Black",
      fileExtension: "otf"
    ),
    NeoBrutalFontResource(
      postScriptName: "IBMPlexMono-Bold",
      fileName: "IBMPlexMono-Bold",
      fileExtension: "ttf"
    ),
    NeoBrutalFontResource(
      postScriptName: "IBMPlexMono-Regular",
      fileName: "IBMPlexMono-Regular",
      fileExtension: "ttf"
    ),
    NeoBrutalFontResource(
      postScriptName: "IBMPlexMono-Light",
      fileName: "IBMPlexMono-Light",
      fileExtension: "ttf"
    ),
    NeoBrutalFontResource(
      postScriptName: "IBMPlexMono-Thin",
      fileName: "IBMPlexMono-Thin",
      fileExtension: "ttf"
    ),
  ].reduce(into: [String: NeoBrutalFontResource]()) { $0[$1.postScriptName] = $1 }

  private static let didRegister = OSAllocatedUnfairLock(initialState: Set<String>())

  static func registerIfNeeded(string: String) {
    let shouldRegister = didRegister.withLock { registry in
      registry.insert(string).inserted
    }
    guard shouldRegister,
      let resource = resources[string],
      let url = Bundle.module.url(
        forResource: resource.fileName,
        withExtension: resource.fileExtension
      )
    else { return }
    var error: Unmanaged<CFError>?
    let wasRegistered = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)

    if !wasRegistered {
      if let error {
        let nsError = error.takeUnretainedValue() as Error
        assertionFailure(
          "Failed to register font: \(resource.postScriptName) - \(nsError.localizedDescription)")
      } else {
        assertionFailure("Failed to register font: \(resource.postScriptName)")
      }
    }
  }
}

extension Font {
  static func neoBrutalCustom(_ name: String, size: CGFloat) -> Font {
    NeoBrutalFontRegistrar.registerIfNeeded(string: name)
    return .custom(name, size: size)
  }
}
