# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NeoBrutalistUI is a cross-platform (iOS 17+ / macOS 15+) SwiftUI component library implementing neo-brutalist design principles with bold geometry, high-contrast colors, and hard-edged shadows. The package includes both the library and a demo app target that showcases all components.

## Common Commands

### Building and Testing
```bash
# Build the package
swift build

# Run tests
swift test

# Run the demo app
swift run NeoBrutalistDemo

# Generate visual snapshots for testing
swift run NeoBrutalistSnapshots

# Generate snapshots for specific themes
SNAPSHOT_THEMES=bubblegum,nocturneVolt swift run NeoBrutalistSnapshots
```

### Opening in Xcode
```bash
open Package.swift
```

## Architecture

### Core Theme System

The library uses a centralized theme system built around `NeoBrutalistTheme` (Theme/NeoBrutalistTheme.swift:6). Themes are injected via SwiftUI environment and control all visual styling:

- **Palette**: Defines primary/secondary/highlight colors for background, surface, and accent layers
- **Typography**: Provides bodyFont and monoFont configurations
- **Visual Properties**: borderWidth, cornerRadius, shadowOffset, shadowRadius, shadowOpacity, noiseOpacity
- **Window Properties**: Special properties for macOS window styling (windowButtonSize, windowShadowOffset, etc.)

Access the current theme in any component via `@Environment(\.neoBrutalistTheme)`.

### Theme Application Pattern

Apply themes to view hierarchies using the `.neoBrutalistTheme()` modifier (Theme/NeoBrutalistTheme.swift:191):
```swift
ContentView()
    .neoBrutalistTheme(.bubblegum)
```

Built-in themes: bubblegum, daybreakPlaza, nocturneVolt, ultravioletCargo, desert, jungle, crimsonFury.

### Component Architecture

All components follow a consistent pattern:
1. Use `.nb` syntax for colors (e.g., `.foregroundStyle(.nb.textPrimary)`)
2. Use `@Environment(\.neoBrutalistTheme)` only when accessing non-color theme properties (typography, borderWidth, spacing, etc.)
3. Apply `neoBrutalistShadow()` helper for hard-edged or soft shadows (Core/NeoBrutalistHelpers.swift:20)
4. Components automatically adapt to theme changes

Components are located in `Sources/NeoBrutalistUI/Components/`.

**When to use `@Environment`**: You still need `@Environment(\.neoBrutalistTheme) private var theme` when accessing:
- Typography: `theme.typography.bodyFont`, `theme.typography.titleFont`
- Layout properties: `theme.borderWidth`, `theme.cornerRadius`, `theme.shadowOffset`
- Other non-color properties: `theme.noiseOpacity`, `theme.windowButtonSize`

### Shadow System

The library implements a custom shadow system (Core/NeoBrutalistHelpers.swift:20-68) that supports both:
- **Hard-edged shadows**: When `shadowRadius` is 0, creates a solid offset background layer
- **Soft shadows**: When `shadowRadius` > 0, uses standard SwiftUI shadows

### Color System

The library provides two ways to access theme colors:

#### Ergonomic Color Access (Recommended)
Use the `.nb` namespace for direct color access without needing `@Environment`:
```swift
Text("Title")
    .foregroundStyle(.nb.textPrimary)
    .background(.nb.surface.primary)

Circle()
    .fill(.nb.accent.primary)
    .stroke(.nb.accent.highlight, lineWidth: 2)
```

Available colors:
- Palettes: `.nb.background`, `.nb.surface`, `.nb.accent` (each with `.primary`, `.secondary`, `.highlight`)
- Text: `.nb.textPrimary`, `.nb.textMuted`

**Important**: Use `.foregroundStyle()` instead of `.foregroundColor()` with `.nb` colors. The `.nb` syntax returns a `NeoBrutalistColor` which is a `ShapeStyle`, not a `Color`.

#### Traditional Access
For cases requiring explicit `Color` types or complex operations:
```swift
@Environment(\.neoBrutalistTheme) private var theme
let color: Color = theme.textPrimary.color
```

`PaletteColor` (Theme/Palette.swift:215) stores RGB values (0-255 or 0-1) and alpha. `Palette` groups three related colors (primary, secondary, highlight) and provides a gradient generator.

### Noise Texture

`NeoBrutalistNoise` (Core/NeoBrutalistHelpers.swift:70) generates a procedural grayscale noise texture at runtime for brutalist texture effects. Controlled via theme's `noiseOpacity` property.

### Package Structure

- **NeoBrutalistUI** (library target): Public SwiftUI components and theming system
- **NeoBrutalistDemo** (executable target): Lives in `Examples/NeoBrutalistDemo`, showcases all components
- **NeoBrutalistSnapshots** (executable target): Lives in `Examples/NeoBrutalistSnapshots`, generates PNG snapshots of all components across themes for visual regression testing
- **NeoBrutalistUITests**: Unit tests for theme utilities and color math

### Snapshot Testing

The library includes an automated visual testing system that generates PNG snapshots of all components:

```bash
# Generate snapshots for all themes
swift run NeoBrutalistSnapshots

# Test specific themes only
SNAPSHOT_THEMES=bubblegum,crimsonFury swift run NeoBrutalistSnapshots

# Custom output directory
SNAPSHOT_OUTPUT=/path/to/output swift run NeoBrutalistSnapshots
```

Snapshots are saved to `./Snapshots/` organized by theme. This is useful for:
- Visual regression testing after refactoring
- Verifying theme changes across all components
- Generating documentation screenshots
- CI/CD visual validation

See `SNAPSHOT_TESTING.md` for full documentation.

### Platform Differences

Components use conditional compilation for platform-specific features:
```swift
#if os(macOS)
// macOS-specific code
#else
// iOS-specific code
#endif
```

### Spacing Convention

Use `NeoBrutalist.Spacing` enum (Core/NeoBrutalistExports.swift:6) for consistent spacing:
- xsmall: 6pt
- small: 12pt
- medium: 18pt
- large: 28pt
- xlarge: 42pt

## Development Notes

- Minimum Swift version: 6.2
- The demo app uses only public API - anything shown there can be used in external apps
- All visual parameters are theme-driven; avoid hardcoding colors or dimensions
- When creating new components, follow the environment-based theming pattern used in existing components
