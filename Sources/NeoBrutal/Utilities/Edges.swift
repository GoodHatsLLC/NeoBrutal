import SwiftUI

struct Edges: Hashable {
  public var top: CGFloat
  public var leading: CGFloat
  public var bottom: CGFloat
  public var trailing: CGFloat
  init(insets: EdgeInsets) {
    self.top = insets.top
    self.leading = insets.leading
    self.bottom = insets.bottom
    self.trailing = insets.trailing
  }

}
