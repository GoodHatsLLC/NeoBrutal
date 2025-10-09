import NeoBrutalistUI
import SwiftUI

/// Defines test cases for each component
@MainActor
struct ComponentTestCases {
  /// All available test cases
  static var all: [SnapshotTestCase] {
    [
      buttonsTestCase,
      cardsTestCase,
      togglesTestCase,
      badgesTestCase,
      surfacesTestCase,
      slidersTestCase,
      textFieldsTestCase,
      disclosureGroupsTestCase,
      menusTestCase,
      backgroundTestCase,
    ]
  }

  // MARK: - Button Tests

  static var buttonsTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "buttons",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          NeoBrutalistButton(size: .compact) {
            print("Compact")
          } label: {
            Text("Compact Button")
          }

          NeoBrutalistButton(size: .regular) {
            print("Regular")
          } label: {
            Text("Regular Button")
          }

          NeoBrutalistButton(size: .prominent) {
            print("Prominent")
          } label: {
            Label("Prominent Action", systemImage: "star.fill")
          }

          NeoBrutalistButton(size: .regular) {
            print("Disabled")
          } label: {
            Text("Disabled Button")
          }
          .disabled(true)
        }
        .padding()
      )
    )
  }

  // MARK: - Card Tests

  static var cardsTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "cards",
      config: .wide,
      view: AnyView(
        VStack(spacing: 20) {
          NeoBrutalistCard(
            title: "Simple Card",
            subtitle: "Basic Example"
          ) {
            Text("Card content goes here. This is a simple card with a title and subtitle.")
          }

          NeoBrutalistCard(
            title: "Highlighted Card",
            subtitle: "With Icon",
            icon: Image(systemName: "sparkles"),
            accentEdge: .trailing,
            highlighted: true
          ) {
            Text("This card is highlighted with an accent edge.")
          }
        }
        .padding()
      )
    )
  }

  // MARK: - Toggle Tests

  static var togglesTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "toggles",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          Toggle(isOn: .constant(true)) {
            Text("Enabled Toggle")
          }
          .toggleStyle(.neoBrutalist(size: .compact))

          Toggle(isOn: .constant(false)) {
            Text("Disabled Toggle")
          }
          .toggleStyle(.neoBrutalist(size: .regular))

          Toggle(isOn: .constant(true)) {
            Text("Large Toggle")
          }
          .toggleStyle(.neoBrutalist(size: .large))
        }
        .padding()
      )
    )
  }

  // MARK: - Badge Tests

  static var badgesTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "badges",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          HStack(spacing: 12) {
            NeoBrutalistBadge("Live", icon: Image(systemName: "dot.scope"), isActive: true)
            NeoBrutalistBadge("Pending", icon: Image(systemName: "hourglass"), isActive: false)
            NeoBrutalistBadge("Offline", icon: Image(systemName: "moon.zzz"), isActive: false)
          }

          HStack(spacing: 12) {
            NeoBrutalistBadge("Status", placement: .leading)
            NeoBrutalistBadge(
              "Active", icon: Image(systemName: "checkmark"), placement: .trailing, isActive: true)
          }
        }
        .padding()
      )
    )
  }

  // MARK: - Surface Tests

  static var surfacesTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "surfaces",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          Text("Basic Surface")
            .padding()
            .neoBrutalistSurface(accentEdge: .leading)

          Text("Highlighted Surface")
            .padding()
            .neoBrutalistSurface(accentEdge: .trailing, highlighted: true)

          Text("Top Accent")
            .padding()
            .neoBrutalistSurface(accentEdge: .top)
        }
        .padding()
      )
    )
  }

  // MARK: - Slider Tests

  static var slidersTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "sliders",
      config: .standard,
      view: AnyView(
        VStack(spacing: 30) {
          NeoBrutalistSlider(
            "Volume",
            value: .constant(0.65),
            in: 0...1,
            accessibilityLabel: "Volume slider"
          )

          NeoBrutalistSlider(
            value: .constant(0.3),
            in: 0...1,
            showsValueLabel: false,
            accessibilityLabel: "Progress slider"
          )
        }
        .padding()
      )
    )
  }

  // MARK: - TextField Tests

  static var textFieldsTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "textfields",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          NeoBrutalistTextField("Username", text: .constant(""))
          NeoBrutalistTextField("Email", text: .constant("user@example.com"))
          NeoBrutalistTextField("Password", text: .constant("••••••••"))
        }
        .padding()
      )
    )
  }

  // MARK: - Disclosure Group Tests

  static var disclosureGroupsTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "disclosure-groups",
      config: .standard,
      view: AnyView(
        VStack(spacing: 20) {
          NeoBrutalistDisclosureGroup(
            isExpanded: .constant(false),
            accentEdge: .leading
          ) {
            Text("Collapsed Group")
          } content: {
            Text("This content is hidden when collapsed.")
          }

          NeoBrutalistDisclosureGroup(
            isExpanded: .constant(true),
            accentEdge: .trailing,
            highlighted: true
          ) {
            Text("Expanded Group")
          } content: {
            Text("This content is visible when expanded.\nIt can contain multiple lines.")
          }
        }
        .padding()
      )
    )
  }

  // MARK: - Menu Tests

  static var menusTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "menus",
      config: .compact,
      view: AnyView(
        VStack(spacing: 20) {
          NeoBrutalistMenu("Actions", systemImage: "ellipsis.circle") {
            NeoBrutalistMenuItem("Export", systemImage: "square.and.arrow.up") {}
            NeoBrutalistMenuItem("Refresh", systemImage: "arrow.clockwise") {}
            Divider()
            NeoBrutalistMenuItem("Delete", systemImage: "trash", destructive: true) {}
          }

          NeoBrutalistMenu("Options", size: .compact) {
            NeoBrutalistMenuItem("Settings") {}
            NeoBrutalistMenuItem("Help") {}
          }
        }
        .padding()
      )
    )
  }

  // MARK: - Background Tests

  static var backgroundTestCase: SnapshotTestCase {
    SnapshotTestCase(
      name: "background",
      config: .standard,
      view: AnyView(
        ZStack {
          NeoBrutalistBackground(gridSpacing: 40, showsGrid: true)

          Text("Background with Grid")
            .font(.largeTitle)
            .foregroundStyle(.nb.textPrimary)
        }
      )
    )
  }
}

/// A single snapshot test case
struct SnapshotTestCase {
  let name: String
  let config: SnapshotConfig
  let view: AnyView
}
