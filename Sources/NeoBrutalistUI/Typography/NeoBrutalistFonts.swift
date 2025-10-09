import CoreText
import SwiftUI
import os

private struct NeoBrutalistFontResource {
  let postScriptName: String
  let fileName: String
  let fileExtension: String
}

enum NeoBrutalistFontRegistrar {
  private static let resources: [String: NeoBrutalistFontResource] = [
    NeoBrutalistFontResource(
      postScriptName: "Inter-Medium",
      fileName: "Inter-Medium",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Aspekta-300",
      fileName: "Aspekta-300",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Aspekta-500",
      fileName: "Aspekta-500",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Aspekta-700",
      fileName: "Aspekta-700",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "CabinetGrotesk-Regular",
      fileName: "CabinetGrotesk-Regular",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "CabinetGrotesk-Medium",
      fileName: "CabinetGrotesk-Medium",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "CabinetGrotesk-Bold",
      fileName: "CabinetGrotesk-Bold",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Light",
      fileName: "Zodiak-Light",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Thin",
      fileName: "Zodiak-Thin",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Regular",
      fileName: "Zodiak-Regular",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Bold",
      fileName: "Zodiak-Bold",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Extrabold",
      fileName: "Zodiak-Extrabold",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "Zodiak-Black",
      fileName: "Zodiak-Black",
      fileExtension: "otf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "IBMPlexMono-Bold",
      fileName: "IBMPlexMono-Bold",
      fileExtension: "ttf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "IBMPlexMono-Regular",
      fileName: "IBMPlexMono-Regular",
      fileExtension: "ttf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "IBMPlexMono-Light",
      fileName: "IBMPlexMono-Light",
      fileExtension: "ttf"
    ),
    NeoBrutalistFontResource(
      postScriptName: "IBMPlexMono-Thin",
      fileName: "IBMPlexMono-Thin",
      fileExtension: "ttf"
    ),
  ].reduce(into: [String: NeoBrutalistFontResource]()) { $0[$1.postScriptName] = $1 }

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
  static func neoBrutalistCustom(_ name: String, size: CGFloat) -> Font {
    NeoBrutalistFontRegistrar.registerIfNeeded(string: name)
    return .custom(name, size: size)
  }
}
