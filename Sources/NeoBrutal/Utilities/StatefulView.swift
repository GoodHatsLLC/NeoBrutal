import SwiftUI

struct StatefulView<V: View, S>: View {
  init(initialState: S, @ViewBuilder viewBuilder: @escaping (Binding<S>) -> V) {
    self.state = initialState
    self.viewBuilder = viewBuilder
  }
  @State private var state: S
  @ViewBuilder var viewBuilder: (Binding<S>) -> V
  var body: some View {
    viewBuilder($state)
  }
}
