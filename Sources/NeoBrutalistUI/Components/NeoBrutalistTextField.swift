import SwiftUI

public struct NeoBrutalistTextField: View {
    @Environment(\.neoBrutalistTheme) private var theme
    
    let title: String
    @Binding var text: String
    
    public init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    public var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(theme.surface.primary.color)
            .border(Color.black, width: theme.borderWidth)
            .compositingGroup()
            .shadow(color: .black, radius: 0, x: theme.shadowOffset.width, y: theme.shadowOffset.height)
    }
}
