import SwiftUI

extension View {
    func readingSize(into size: Binding<CGSize>, safeArea: Binding<EdgeInsets> = .constant(.init())) -> some View {
    self
      .background {
        GeometryReader { proxy in
          Color.clear
                .task(id: AnyHashable(many: proxy.size, Edges(insets: proxy.safeAreaInsets))) {
              size.wrappedValue = proxy.size
                safeArea.wrappedValue = proxy.safeAreaInsets
            }
        }
        .hidden()
      }
  }
}

