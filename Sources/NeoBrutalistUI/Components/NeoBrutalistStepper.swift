import SwiftUI

public struct NeoBrutalistStepper: View {
    @Environment(\.neoBrutalistTheme) private var theme
    
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    public init(value: Binding<Int>, in range: ClosedRange<Int>) {
        self._value = value
        self.range = range
    }
    
    public var body: some View {
        HStack {
            Button(action: { 
                if value > range.lowerBound {
                    value -= 1
                }
            }) {
                Image(systemName: "minus")
            }
            .buttonStyle(NeoBrutalistStepperButtonStyle(theme: theme))
            
            Text("\(value)")
                .font(theme.typography.bodyFont)
                .padding(.horizontal)
            
            Button(action: { 
                if value < range.upperBound {
                    value += 1
                }
            }) {
                Image(systemName: "plus")
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
            .background(theme.surface.primary.color)
            .foregroundColor(theme.textPrimary.color)
            .border(Color.black, width: theme.borderWidth)
            .shadow(color: .black, radius: 0, x: theme.shadowOffset.width, y: theme.shadowOffset.height)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
