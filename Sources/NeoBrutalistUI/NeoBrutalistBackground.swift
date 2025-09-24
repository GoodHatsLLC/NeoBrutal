import SwiftUI

/// A textured backdrop that reinforces the Neo Brutalist look.
public struct NeoBrutalistBackground: View {
    private let gridSpacing: CGFloat
    private let showsGrid: Bool

    @Environment(\.neoBrutalistTheme) private var theme

    public init(gridSpacing: CGFloat = 32, showsGrid: Bool = true) {
        self.gridSpacing = gridSpacing
        self.showsGrid = showsGrid
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                theme.background.primary.color
                    .ignoresSafeArea()

                if showsGrid {
                    grid
                        .ignoresSafeArea()
                }
            }
        }
    }

    private var grid: some View {
        Canvas { context, size in
            let path = Path { path in
                let columns = Int(size.width / gridSpacing)
                let rows = Int(size.height / gridSpacing)

                for column in 0...columns {
                    let x = CGFloat(column) * gridSpacing
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                }

                for row in 0...rows {
                    let y = CGFloat(row) * gridSpacing
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                }
            }

            context.stroke(path, with: .color(theme.background.highlight.color.opacity(0.15)), lineWidth: 1)
        }
    }
}
