import SwiftUI

/// A custom slider tailored to the Neo Brutalist theme with thick geometry and an animated thumb.
public struct NeoBrutalSlider<Label: View>: View {
  @Environment(\.nb) private var nbTheme

  @Binding private var value: Double
  private let range: ClosedRange<Double>
  private let step: Double?
  private let showsValueLabel: Bool
  private let valueFormatter: (Double) -> String
  private let label: (() -> Label)?
  private let accessibilityLabelText: String

  @State private var isDragging = false

  /// Creates a Neo Brutalist slider with a custom label view.
  /// - Parameters:
  ///   - value: The bound value to control.
  ///   - range: The permitted range of values.
  ///   - step: Optional step interval that the slider snaps to while dragging.
  ///   - showsValueLabel: Controls whether the formatted value is shown below the track.
  ///   - accessibilityLabel: Optional accessibility label. Defaults to the string "Slider".
  ///   - valueFormatter: Optional formatter closure for the value label.
  ///   - label: Builder for the label shown above the slider.
  public init(
    value: Binding<Double>,
    in range: ClosedRange<Double> = 0...1,
    step: Double? = nil,
    showsValueLabel: Bool = true,
    accessibilityLabel: String? = nil,
    valueFormatter: ((Double) -> String)? = nil,
    @ViewBuilder label: @escaping () -> Label
  ) {
    self._value = value
    self.range = range
    self.step = step
    self.showsValueLabel = showsValueLabel
    self.valueFormatter = valueFormatter ?? Self.defaultFormatter(step: step, range: range)
    self.label = label
    self.accessibilityLabelText = accessibilityLabel ?? "Slider"
  }

  /// Creates a Neo Brutalist slider without a label.
  public init(
    value: Binding<Double>,
    in range: ClosedRange<Double> = 0...1,
    step: Double? = nil,
    showsValueLabel: Bool = true,
    accessibilityLabel: String? = nil,
    valueFormatter: ((Double) -> String)? = nil
  ) where Label == EmptyView {
    self._value = value
    self.range = range
    self.step = step
    self.showsValueLabel = showsValueLabel
    self.valueFormatter = valueFormatter ?? Self.defaultFormatter(step: step, range: range)
    self.label = nil
    self.accessibilityLabelText = accessibilityLabel ?? "Slider"
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: NeoBrutal.Spacing.small.rawValue) {
      if let label {
        label()
          .font(nbTheme.typography.bodyFont)
          .foregroundStyle(.nb.textPrimary)
      }

      sliderBody

      if showsValueLabel {
        Text(valueFormatter(value))
          .font(nbTheme.typography.monoFont)
          .foregroundStyle(.nb.textMuted)
          .padding(.top, 2)
      }
    }
    .accessibilityLabel(Text(accessibilityLabelText))
    .accessibilityValue(Text(valueFormatter(value)))
    .accessibilityAdjustableAction { direction in
      let delta = step ?? (range.upperBound - range.lowerBound) * 0.05
      switch direction {
      case .increment:
        adjustValue(by: delta)
      case .decrement:
        adjustValue(by: -delta)
      @unknown default:
        break
      }
    }
  }

  private var sliderBody: some View {
    GeometryReader { geometry in
      let trackWidth = max(geometry.size.width, 1)
      let knobSize: CGFloat = 34
      let trackHeight: CGFloat = 12
      let progress = progressValue()
      let knobCenter = CGFloat(progress) * trackWidth
      let knobOffset = max(
        0, min(knobCenter - knobSize / 2, trackWidth - knobSize - nbTheme.shadowOffset.width))
      let fillWidth = min(max(knobCenter, knobSize * 0.4), trackWidth)

      ZStack(alignment: .leading) {

        baseTrack(height: trackHeight)
        progressTrack(width: fillWidth, height: trackHeight)
        knob(size: knobSize)
          .offset(x: knobOffset)
      }
      .frame(height: max(knobSize, 48))
      .contentShape(Rectangle())
      .highPriorityGesture(
        DragGesture(minimumDistance: 0)
          .onChanged { drag in
            let clampedX = min(max(drag.location.x, 0), trackWidth)
            updateValue(for: clampedX, width: trackWidth)
            if !isDragging {
              withAnimation(.easeOut(duration: 0.15)) {
                isDragging = true
              }
            }
          }
          .onEnded { drag in
            let clampedX = min(max(drag.location.x, 0), trackWidth)
            updateValue(for: clampedX, width: trackWidth)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
              isDragging = false
            }
          }
      )
    }
    .frame(height: 56)
    .padding(.horizontal, nbTheme.borderWidth)
  }

  private func baseTrack(height: CGFloat) -> some View {
    RoundedRectangle(
      cornerRadius: nbTheme.cornerRadius == 0 ? 6 : nbTheme.cornerRadius, style: .continuous
    )
    .fill(.nb.surface.secondary.opacity(0.65))
    .overlay(
      RoundedRectangle(
        cornerRadius: nbTheme.cornerRadius == 0 ? 6 : nbTheme.cornerRadius, style: .continuous
      )
      .stroke(.nb.surface.highlight.opacity(0.8), lineWidth: max(nbTheme.borderWidth * 0.8, 1))
    )
    .frame(height: height)
    .padding(.horizontal, nbTheme.shadowOffset.width)
  }

  private func progressTrack(width: CGFloat, height: CGFloat) -> some View {
    RoundedRectangle(
      cornerRadius: nbTheme.cornerRadius == 0 ? 6 : nbTheme.cornerRadius, style: .continuous
    )
    .fill(.nb.accent.primary.opacity(0.75))
    .overlay(
      RoundedRectangle(
        cornerRadius: nbTheme.cornerRadius == 0 ? 6 : nbTheme.cornerRadius, style: .continuous
      )
      .stroke(.nb.accent.highlight.opacity(0.9), lineWidth: max(nbTheme.borderWidth * 0.6, 1))
    )
    .frame(width: width - nbTheme.shadowOffset.width * 2, height: height)
    .padding(.horizontal, nbTheme.shadowOffset.width)
  }

  private func knob(size: CGFloat) -> some View {
    RoundedRectangle(cornerRadius: nbTheme.shadowRadius, style: .continuous)
      .fill(isDragging ? Color.nb.accent.highlight : Color.nb.accent.primary)
      .frame(width: size, height: size)
      .overlay(
        RoundedRectangle(cornerRadius: nbTheme.shadowRadius, style: .continuous)
          .stroke(Color.black.opacity(0.12), lineWidth: 1)
      )
      .neoBrutalShadow(
        color: Color.black.opacity(
          isDragging ? min(1, nbTheme.shadowOpacity + 0.2) : nbTheme.shadowOpacity),
        radius: nbTheme.shadowRadius,
        offset: nbTheme.shadowOffset,
        isEnabled: true,
        cornerRadius: nbTheme.shadowRadius
      )
      .offset(x: -nbTheme.borderWidth - nbTheme.shadowOffset.width, y: -nbTheme.borderWidth / 2)
      .scaleEffect(isDragging ? 1.05 : 1)
      .animation(.easeOut(duration: 0.15), value: isDragging)
      .padding(.horizontal, nbTheme.shadowOffset.width)
  }

  private func progressValue() -> Double {
    guard range.upperBound != range.lowerBound else { return 0 }
    let clamped = min(max(value, range.lowerBound), range.upperBound)
    return (clamped - range.lowerBound) / (range.upperBound - range.lowerBound)
  }

  private func updateValue(for location: CGFloat, width: CGFloat) {
    guard width > 0 else { return }
    let ratio = Double(location / width)
    let candidate = range.lowerBound + (range.upperBound - range.lowerBound) * ratio
    applyValue(candidate)
  }

  private func adjustValue(by delta: Double) {
    let candidate = value + delta
    applyValue(candidate)
  }

  private func applyValue(_ candidate: Double) {
    let clipped = min(max(candidate, range.lowerBound), range.upperBound)
    let stepped = step.map { snap(clipped, to: $0) } ?? clipped
    if stepped != value {
      value = stepped
    }
  }

  private func snap(_ candidate: Double, to step: Double) -> Double {
    guard step > 0 else { return candidate }
    let steps = (candidate - range.lowerBound) / step
    let rounded = steps.rounded()
    let snapped = range.lowerBound + rounded * step
    return min(max(snapped, range.lowerBound), range.upperBound)
  }

  private static func defaultFormatter(step: Double?, range: ClosedRange<Double>) -> (Double) ->
    String
  {
    if let step, step >= 1, step == floor(step) {
      return { value in String(Int(value.rounded())) }
    } else if range.lowerBound >= 0, range.upperBound <= 1 {
      return { value in String(format: "%.0f%%", value * 100) }
    } else {
      return { value in String(format: "%.2f", value) }
    }
  }
}

extension NeoBrutalSlider where Label == Text {
  /// Convenience initializer that accepts a plain text label.
  public init(
    _ title: String,
    value: Binding<Double>,
    in range: ClosedRange<Double> = 0...1,
    step: Double? = nil,
    showsValueLabel: Bool = true,
    accessibilityLabel: String? = nil,
    valueFormatter: ((Double) -> String)? = nil
  ) {
    self.init(
      value: value,
      in: range,
      step: step,
      showsValueLabel: showsValueLabel,
      accessibilityLabel: accessibilityLabel ?? title,
      valueFormatter: valueFormatter
    ) {
      Text(title)
    }
  }
}
