import SwiftUI

public struct NeoBrutalistStepper: View {
    @Environment(\.neoBrutalistTheme) private var theme
    
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    public init(value: Binding<Int>, in range: ClosedRange<Int>) {
        self._value = value
        self.range = range
    }

    @ScaledMetric(relativeTo: .title2) var h2  = 20

    public var body: some View {
        HStack {
                Button(action: {
                    if value > range.lowerBound {
                        withAnimation {
                            value -= 1
                        }
                    }
                }) {
                    Image(systemName: "minus")
                        .frame(width: h2, height: h2)
                }
                .buttonStyle(NeoBrutalistButtonStyle())

            if #available(macOS 26.0, *) {
                Text("\(value)")
                    .font(theme.typography.monoFont.pointSize(h2))
                    .contentTransition(.numericText(value: Double(value)))
                    .padding()
            } else {
                Text("\(value)")
                    .font(theme.typography.monoFont)
                    .contentTransition(.numericText(value: Double(value)))
                    .padding()
            }
                Button(action: {
                    if value < range.upperBound {
                        withAnimation {
                            value += 1
                        }
                    }
                }) {
                    Image(systemName: "plus")
                        .frame(width: h2, height: h2)
                }
                .buttonStyle(NeoBrutalistButtonStyle())
        }
    }
}
