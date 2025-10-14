import SwiftUI

extension View {
  func onTouchUpInside(
    downInside: Binding<Bool> = .constant(false),
    action: @escaping (_ time: TimeInterval) -> Void = { _ in }
  ) -> some View {
    self.modifier(TouchUpInsideModifier(touchingDownInside: downInside, action: action))
  }
}

struct TouchUpInsideModifier: ViewModifier {
  init(
    touchingDownInside: Binding<Bool>,
    action: @escaping (_ len: TimeInterval) -> Void
  ) {
    self.action = action
    _isTouchingDown = touchingDownInside
  }

  let action: (TimeInterval) -> Void
  @Binding var isTouchingDown: Bool
  @State var size: CGSize = .zero
  @State var isInside: Bool = false
  @State var start: Date?

  func body(content: Content) -> some View {
    content
      .readingSize(into: $size)
      .simultaneousGesture(
        DragGesture(minimumDistance: 0)
          .onChanged { touch in
            isInside =
              touch.translation.width >= 0 && touch.translation.height >= 0
              && touch.translation.width < size.width
              && touch.translation.height < size.height
            if isInside {
              start = start ?? Date.now
            }
          }
          .onEnded { touch in
            if isInside {
              action(Date.now.timeIntervalSince(start ?? Date.now))
            }
            start = nil
            isInside = false
          }
      )
      .onChange(of: isInside) { _, new in
        isTouchingDown = new
      }
  }
}
