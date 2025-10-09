import NeoBrutalistUI
import SwiftUI

struct DemoRootView: View {
  @Binding var selectedTheme: NeoBrutalistTheme
  @Environment(\.colorScheme) private var colorScheme

  @State private var notificationsEnabled = true
  @State private var intensity: Double = 0.65
  @State private var logItems: [DemoLogItem] = DemoLogItem.seed

  @State private var textFieldValue = "Hello, world!"

  @State private var stepperValue = 0

  private let themeOptions: [NeoBrutalistTheme] = NeoBrutalist.standardThemes

  private var selectedVariant: NeoBrutalistTheme.Variant {
    selectedTheme.variant(for: colorScheme)
  }

  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .top) {
        NeoBrutalistBackground(gridSpacing: 33)

        ScrollView {
          LazyVStack(alignment: .leading, spacing: NeoBrutalist.Spacing.large.rawValue) {
            themeGallery
            introCard
            group
            controlPanel
            activityFeed
          }
          .padding(.horizontal, NeoBrutalist.Spacing.large.rawValue)
          .padding(.vertical, NeoBrutalist.Spacing.large.rawValue)
          .frame(minWidth: proxy.size.width)
        }
      }
    }
  }

  private var themeGallery: some View {
    NeoBrutalistCard(
      title: "Theme Picker",
      subtitle: "Curated Palettes",
      icon: Image(systemName: "paintpalette.fill"),
      accentEdge: .top
    ) {
      LazyVGrid(
        columns: [
          GridItem(.adaptive(minimum: 220), spacing: NeoBrutalist.Spacing.medium.rawValue)
        ],
        spacing: NeoBrutalist.Spacing.medium.rawValue
      ) {
        ForEach(themeOptions) { option in
          Button {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
              selectedTheme = option
            }
          } label: {
            ThemeSwatch(option: option, isSelected: option == selectedTheme)
          }
          .buttonStyle(.plain)
        }
      }
    }
  }

  private var introCard: some View {
    NeoBrutalistCard(
      title: "Neo Brutalist UI",
      subtitle: "Component Library",
      icon: Image(systemName: "sparkles")
    ) {
      Text(
        "A SwiftUI showcase for iOS and macOS that embraces bold geometry, unapologetic color, and tactile depth."
      )
      Text(
        "Toggle between curated themes, mix components, and view the library in action inside a single Swift Package."
      )
    }
  }

  private var group: some View {
    NeoBrutalistDisclosureGroup {
      Text("Group")
    } content: {
      Text("Content")
    }
  }

  private var controlPanel: some View {
    VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.large.rawValue) {
      NeoBrutalistCard(
        title: "Controls", subtitle: "Interactive Elements",
        icon: Image(systemName: "slider.horizontal.3")
      ) {
        VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.medium.rawValue) {
          NeoBrutalistButton(size: .prominent) {
            log(
              "Primary action fired at intensity \(String(format: "%.2f", intensity))"
            )
          } label: {
            Label("Deploy Sequence", systemImage: "bolt.fill")
              .labelStyle(.titleAndIcon)
          }

          Toggle(isOn: $notificationsEnabled) {
            Text(notificationsEnabled ? "Alerts Enabled" : "Alerts Disabled")
          }
          .toggleStyle(.neoBrutalist(size: .regular))

          NeoBrutalistSlider(
            "Noise Intensity",
            value: $intensity,
            in: 0...1,
            accessibilityLabel: "Noise intensity"
          )

          NeoBrutalistTextField("Text Field", text: $textFieldValue)

          NeoBrutalistStepper(value: $stepperValue, in: 0...10)

          NeoBrutalistMenu("Actions", systemImage: "ellipsis.circle") {
            NeoBrutalistMenuItem("Export Data", systemImage: "square.and.arrow.up") {
              log("Export data action triggered")
            }

            NeoBrutalistMenuItem("Refresh", systemImage: "arrow.clockwise") {
              log("Refresh action triggered")
            }

            Divider()

            NeoBrutalistMenuItem("Settings", systemImage: "gear") {
              log("Settings opened")
            }

            NeoBrutalistMenuItem("Delete", systemImage: "trash", destructive: true) {
              log("Delete action triggered")
            }
          }
        }
      }

      NeoBrutalistCard(
        title: "Badges", subtitle: "Status Chips", icon: Image(systemName: "tag.fill"),
        accentEdge: .trailing
      ) {
        VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.small.rawValue) {
          Text("Use badges to build status dashboards or highlight filters.")
            .foregroundColor(selectedVariant.textMuted.color)

          LazyVGrid(
            columns: [
              GridItem(
                .adaptive(minimum: 140),
                spacing: NeoBrutalist.Spacing.small.rawValue)
            ], spacing: NeoBrutalist.Spacing.small.rawValue
          ) {
            ForEach(DemoLogItem.Status.allCases, id: \.self) { status in
              NeoBrutalistBadge(
                status.label, icon: Image(systemName: status.iconName),
                placement: .leading, isActive: status == .live)
            }
          }
        }
      }
    }
  }

  private var activityFeed: some View {
    NeoBrutalistCard(
      title: "Mission Log", subtitle: "Live Events",
      icon: Image(systemName: "antenna.radiowaves.left.and.right"), accentEdge: .trailing,
      highlighted: true
    ) {
      VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.medium.rawValue) {
        ForEach(logItems.prefix(5)) { log in
          VStack(alignment: .leading, spacing: 6) {
            Text(log.title)
              .font(selectedVariant.typography.bodyFont)
              .foregroundColor(selectedVariant.accent.highlight.color)
            Text(log.message)
              .font(selectedVariant.typography.monoFont)
              .foregroundColor(selectedVariant.textMuted.color)
          }
          .padding(.vertical, 6)
          .overlay(alignment: .bottom) {
            Rectangle()
              .frame(height: 1)
              .foregroundColor(selectedVariant.surface.secondary.color.opacity(0.35))
          }
        }
      }
    }
  }

  private func log(_ message: String) {
    withAnimation {
      let item = DemoLogItem(title: "Event", message: message)
      logItems.insert(item, at: 0)
    }
  }

}

// MARK: - Supporting Models

private struct ThemeSwatch: View {
  let option: NeoBrutalistTheme
  let isSelected: Bool
  @Environment(\.colorScheme) private var colorScheme

  private var themeVariant: NeoBrutalistTheme.Variant {
    option.variant(for: colorScheme)
  }

  var body: some View {
    VStack(alignment: .leading, spacing: NeoBrutalist.Spacing.small.rawValue) {
      ZStack(alignment: .topTrailing) {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .fill(themeVariant.background.gradient)
          .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
              .stroke(styleBorderColor, lineWidth: isSelected ? 4 : 2)
          )
          .frame(height: 96)

        Circle()
          .fill(themeVariant.accent.highlight.color)
          .frame(width: 24, height: 24)
          .overlay(
            Circle()
              .stroke(Color.white.opacity(0.75), lineWidth: 2)
          )
          .padding(12)
      }

      VStack(alignment: .leading, spacing: 4) {
        Text(option.name)
          .font(themeVariant.typography.bodyFont)
          .foregroundColor(themeVariant.textPrimary.color)

        Text(option.name)
          .font(themeVariant.typography.monoFont)
          .foregroundColor(themeVariant.textMuted.color)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, NeoBrutalist.Spacing.small.rawValue)
      .padding(.bottom, NeoBrutalist.Spacing.small.rawValue)
      .background(
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .fill(themeVariant.surface.primary.color.opacity(0.85))
      )
    }
    .padding(NeoBrutalist.Spacing.small.rawValue)
    .background(
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(themeVariant.surface.secondary.color.opacity(0.55))
        .shadow(
          color: Color.black.opacity(0.1), radius: isSelected ? 10 : 4,
          x: themeVariant.shadowOffset.width, y: themeVariant.shadowOffset.height)
    )
    .overlay(alignment: .topLeading) {
      if isSelected {
        Label("Active", systemImage: "checkmark.seal.fill")
          .font(.system(size: 13, weight: .semibold, design: .rounded))
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .foregroundColor(themeVariant.surface.primary.color)
          .background(
            Capsule(style: .continuous)
              .fill(themeVariant.accent.primary.color)
          )
          .offset(x: 12, y: -10)
      }
    }
    .accessibilityElement(children: .combine)
    .accessibilityLabel(Text(option.name))
    .accessibilityHint(Text("Switch to \(option.name)"))
  }

  private var styleBorderColor: Color {
    isSelected
      ? themeVariant.accent.highlight.color
      : themeVariant.surface.highlight.color.opacity(0.5)
  }
}

private struct DemoLogItem: Identifiable {
  let id = UUID()
  let title: String
  let message: String
  let status: Status

  init(title: String, message: String, status: Status = .live) {
    self.title = title
    self.message = message
    self.status = status
  }
}

extension DemoLogItem {
  fileprivate enum Status: CaseIterable, Hashable {
    case live
    case pending
    case offline

    var label: String {
      switch self {
      case .live: return "Live"
      case .pending: return "Pending"
      case .offline: return "Offline"
      }
    }

    var iconName: String {
      switch self {
      case .live: return "dot.scope"
      case .pending: return "hourglass"
      case .offline: return "moon.zzz"
      }
    }
  }

  fileprivate static let seed: [DemoLogItem] = [
    DemoLogItem(
      title: "Launch Sequence", message: "Stage separation confirmed. Vector locked.",
      status: .live),
    DemoLogItem(
      title: "Diagnostics", message: "Thermal envelope stable at 81%", status: .pending),
    DemoLogItem(
      title: "Payload", message: "Neo Brutalist components compiled for all platforms.",
      status: .live),
    DemoLogItem(
      title: "Telemetry", message: "Signal drop detected in sector 7.", status: .offline),
    DemoLogItem(
      title: "Crew", message: "All operators synced to midnight mode.", status: .live),
  ]
}
