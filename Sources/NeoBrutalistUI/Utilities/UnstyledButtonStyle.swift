import SwiftUI

extension ButtonStyle where Self == UnstyledButtonStyle {
    static var unstyled: UnstyledButtonStyle {
        .init()
    }
}
struct UnstyledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
