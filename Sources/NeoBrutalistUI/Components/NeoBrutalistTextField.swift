import SwiftUI

public struct NeoBrutalistTextField: View {
    @Environment(\.neoBrutalistTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    private var themeVariant: NeoBrutalistTheme.Variant {
        theme.variant(for: colorScheme)
    }
    
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
            .border(Color.primary.opacity(themeVariant.shadowOpacity), width: themeVariant.borderWidth)
            .compositingGroup()
            .neoBrutalistShadow(
                color: Color.primary.opacity(themeVariant.shadowOpacity),
                radius: themeVariant.shadowRadius,
                offset: themeVariant.shadowOffset
            )
    }
}
