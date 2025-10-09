import Foundation

prefix func -(_ size: CGSize) -> CGSize {
    .init(width: -size.width, height: -size.height)
}
func /(_ size: CGSize, _ div: CGFloat) -> CGSize {
    .init(width: size.width/div, height: size.height/div)
}
