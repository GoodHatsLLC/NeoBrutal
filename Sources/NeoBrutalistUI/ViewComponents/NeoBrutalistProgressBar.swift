import SwiftUI

/// A chunky progress bar that displays linear progress from 0–1.
public struct NeoBrutalistProgressBar: View {
  @Environment(\.nb) private var nbTheme
  
  @Binding private var value: Double
  private let showsLabel: Bool
  
  public init(value: Binding<Double>, showsLabel: Bool = false) {
    self._value = value
    self.showsLabel = showsLabel
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.small.rawValue) {
      if showsLabel {
        HStack {
          Text("Progress")
            .font(nbTheme.typography.bodyFont)
            .foregroundStyle(.nb.textPrimary)
          
          Spacer()
          
          Text("\(Int((value * 100).rounded()))%")
            .font(nbTheme.typography.monoFont)
            .foregroundStyle(.nb.textMuted)
        }
      }
      
      progressTrack
    }
  }
  
  private var progressTrack: some View {
    let clampedValue = min(max(value, 0), 1)
    let trackHeight: CGFloat = 16
    
    return GeometryReader { geometry in
      let trackWidth = geometry.size.width
      let fillWidth = trackWidth * CGFloat(clampedValue)
      
      ZStack(alignment: .leading) {
        // Base track
        RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.5, style: .continuous)
          .fill(.nb.surface.secondary)
          .overlay(
            RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.5, style: .continuous)
              .stroke(.nb.surface.highlight.opacity(0.7), lineWidth: nbTheme.borderWidth)
          )
          .frame(height: trackHeight)
        
        // Progress fill
        RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.5, style: .continuous)
          .fill(.nb.accent.primary)
          .overlay(
            RoundedRectangle(cornerRadius: nbTheme.cornerRadius * 0.5, style: .continuous)
              .stroke(.nb.accent.highlight, lineWidth: nbTheme.borderWidth)
          )
          .frame(width: fillWidth, height: trackHeight)
          .animation(.easeInOut(duration: 0.3), value: clampedValue)
      }
    }
    .frame(height: trackHeight)
  }
}