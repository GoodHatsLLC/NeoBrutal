import SwiftUI

public struct StatefulView<V: View, S>: View {
  public init(initialState: S, @ViewBuilder viewBuilder: @escaping (Binding<S>) -> V) {
    self.state = initialState
    self.viewBuilder = viewBuilder
  }
  @State private var state: S
  @ViewBuilder var viewBuilder: (Binding<S>) -> V
  public var body: some View {
    viewBuilder($state)
  }
}
