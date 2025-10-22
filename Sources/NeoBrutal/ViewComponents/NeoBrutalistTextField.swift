import SwiftUI

struct NeoBrutalTextField: View {
  @Environment(\.nb) private var nbTheme

  let title: String
  @Binding var text: String

  public init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
  }

  var body: some View {
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

public enum NeoBrutalStyle {
  case neoBrutal
}

struct NBTFStyle: ViewModifier {
  @Environment(\.nb) var nb

  func body(content: Content) -> some View {
    content
      .padding()
      .background(Color.nb.surface.primary)
      .border(Color.primary.opacity(nb.shadowOpacity), width: nb.borderWidth)
      .compositingGroup()
      .neoBrutalShadow(
        color: Color.primary.opacity(nb.shadowOpacity),
        radius: nb.shadowRadius,
        offset: nb.shadowOffset
      )
  }
}

extension TextField {
  public func textFieldStyle(_: NeoBrutalStyle) -> some View {
    self.textFieldStyle(.plain)
      .modifier(NBTFStyle())
  }
}
