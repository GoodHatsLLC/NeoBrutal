import SwiftUI

public struct NeoBrutalTextField: View {
  @Environment(\.nb) private var nbTheme

  let title: String
  @Binding var text: String

  public init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
  }

  public var body: some View {
    TextField(title, text: $text)
      .textFieldStyle(.plain)
      .padding()
      .background(Color.nb.surface.primary)
      .border(Color.primary.opacity(nbTheme.shadowOpacity), width: nbTheme.borderWidth)
      .compositingGroup()
      .neoBrutalShadow(
        color: Color.primary.opacity(nbTheme.shadowOpacity),
        radius: nbTheme.shadowRadius,
        offset: nbTheme.shadowOffset
      )
  }
}
