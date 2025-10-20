import NeoBrutal
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
          NeoBrutalButton {
            print("Compact")
          } label: {
            Text("Compact Button")
          }.controlSize(.mini)

          NeoBrutalButton {
            print("Small")
          } label: {
            Text("Small Button")
          }.controlSize(.small)

          NeoBrutalButton {
            print("Regular")
          } label: {
            Label("Regular Action", systemImage: "star.fill")
          }.controlSize(.regular)

          NeoBrutalButton {
            print("Large")
          } label: {
            Label("Large Action", systemImage: "star.fill")
          }.controlSize(.large)

          NeoBrutalButton {
            print("Extra Large")
          } label: {
            Label("Extra Large Action", systemImage: "star.fill")
          }.controlSize(.extraLarge)

          NeoBrutalButton {
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
          NeoBrutalCard(
            title: "Simple Card",
            subtitle: "Basic Example"
          ) {
            Text("Card content goes here. This is a simple card with a title and subtitle.")
          }

          NeoBrutalCard(
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
          .toggleStyle(.neoBrutal(size: .compact))

          Toggle(isOn: .constant(false)) {
            Text("Disabled Toggle")
          }
          .toggleStyle(.neoBrutal(size: .regular))

          Toggle(isOn: .constant(true)) {
            Text("Large Toggle")
          }
          .toggleStyle(.neoBrutal(size: .large))
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
            NeoBrutalBadge("Live", icon: Image(systemName: "dot.scope"), isActive: true)
            NeoBrutalBadge("Pending", icon: Image(systemName: "hourglass"), isActive: false)
            NeoBrutalBadge("Offline", icon: Image(systemName: "moon.zzz"), isActive: false)
          }

          HStack(spacing: 12) {
            NeoBrutalBadge("Status", placement: .leading)
            NeoBrutalBadge(
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
            .neoBrutalSurface(accentEdge: .leading)

          Text("Highlighted Surface")
            .padding()
            .neoBrutalSurface(accentEdge: .trailing, highlighted: true)

          Text("Top Accent")
            .padding()
            .neoBrutalSurface(accentEdge: .top)
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
          NeoBrutalSlider(
            "Volume",
            value: .constant(0.65),
            in: 0...1,
            accessibilityLabel: "Volume slider"
          )

          NeoBrutalSlider(
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
          NeoBrutalTextField("Username", text: .constant(""))
          NeoBrutalTextField("Email", text: .constant("user@example.com"))
          NeoBrutalTextField("Password", text: .constant("••••••••"))
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
          NeoBrutalDisclosureGroup(
            isExpanded: .constant(false),
            accentEdge: .leading
          ) {
            Text("Collapsed Group")
          } content: {
            Text("This content is hidden when collapsed.")
          }

          NeoBrutalDisclosureGroup(
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
          NeoBrutalMenu("Actions", systemImage: "ellipsis.circle") {
            NeoBrutalMenuItem("Export", systemImage: "square.and.arrow.up") {}
            NeoBrutalMenuItem("Refresh", systemImage: "arrow.clockwise") {}
            Divider()
            NeoBrutalMenuItem("Delete", systemImage: "trash", destructive: true) {}
          }

          NeoBrutalMenu("Options") {
            NeoBrutalMenuItem("Settings") {}
            NeoBrutalMenuItem("Help") {}
          }
        }
        .padding()
        .controlSize(.small)
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
          NeoBrutalBackground(gridSpacing: 40, showsGrid: true)

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
