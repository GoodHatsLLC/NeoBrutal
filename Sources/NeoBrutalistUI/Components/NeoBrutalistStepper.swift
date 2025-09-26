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
                .buttonStyle(NeoBrutalistStepperButtonStyle(theme: theme))

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
                .buttonStyle(NeoBrutalistStepperButtonStyle(theme: theme))
        }
    }
}

struct NeoBrutalistStepperButtonStyle: ButtonStyle {
    let theme: NeoBrutalistTheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.typography.bodyFont)
            .padding()
            .background {
                Rectangle()
                    .fill(theme.surface.primary.color)
                .border(Color.black, width: theme.borderWidth)
                .compositingGroup()
                .shadow(color: .black, radius: 0, x: theme.shadowOffset.width, y: theme.shadowOffset.height)
            }
            .foregroundColor(theme.textPrimary.color)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0, anchor: .bottomTrailing)
    }
}
