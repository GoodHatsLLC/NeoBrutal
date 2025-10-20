import SwiftUI

struct ReadingSizeModifier: ViewModifier {
  enum Callback: Sendable {
    case binding(Binding<CGSize>)
    case handler(@Sendable (CGSize) -> Void)
  }

  let callback: Callback

  func body(content: Content) -> some View {
    content
      .overlay(
        GeometryReader { proxy in
          Color.clear
            .preference(
              key: SizeInfoPreference.self, value: proxy.frame(in: .global).size.nonnegative
            )
            .onPreferenceChange(SizeInfoPreference.self) { size in
              switch callback {
              case .binding(let binding):
                binding.wrappedValue = size
              case .handler(let handler):
                handler(size)
              }
            }
        }
        .hidden()
      )
  }
}

extension CGSize {
  var nonnegative: CGSize {
    .init(width: max(width, 0), height: max(height, 0))
  }
}

private struct SizeInfoPreference: PreferenceKey {
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }

  static let defaultValue = CGSize.zero
}

extension View {
  public func readingPreferredSize(into binding: Binding<CGSize>) -> some View {
    modifier(ReadingSizeModifier(callback: .binding(binding)))
  }
}

extension View {
  public func readingPreferredSize(with handler: @escaping @Sendable (CGSize) -> Void) -> some View
  {
    modifier(ReadingSizeModifier(callback: .handler(handler)))
  }
}

extension View {
  func readingSize(into size: Binding<CGSize>, safeArea: Binding<EdgeInsets> = .constant(.init()))
    -> some View
  {
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

extension View {
  func readingSize(with: @escaping (_ size: CGSize) -> Void) -> some View {
    self
      .background {
        GeometryReader { proxy in
          Color.clear
            .onChange(
              of: proxy.size,
              initial: true
            ) { oldValue, newValue in
              with(newValue)
            }
        }
        .hidden()
      }
  }
}
