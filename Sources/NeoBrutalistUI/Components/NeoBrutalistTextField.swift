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
            .textFieldStyle(.plain)
            .padding()
            .background(Color.nb.surface.primary)
            .border(Color.primary.opacity(theme.shadowOpacity), width: theme.borderWidth)
            .compositingGroup()
            .neoBrutalistShadow(
                color: Color.primary.opacity(theme.shadowOpacity),
                radius: theme.shadowRadius,
                offset: theme.shadowOffset
            )
    }
}
