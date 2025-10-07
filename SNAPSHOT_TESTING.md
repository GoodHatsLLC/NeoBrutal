# Snapshot Testing

The NeoBrutalistUI library includes an automated snapshot testing system to verify visual appearance of components across different themes.

## Quick Start

### Generate All Snapshots

```bash
swift run NeoBrutalistSnapshots
```

This will:
- Generate snapshots for all components
- Test all 7 built-in themes
- Save PNG files to `./Snapshots/`

### Generate Snapshots for Specific Themes

```bash
# Single theme
SNAPSHOT_THEMES=bubblegum swift run NeoBrutalistSnapshots

# Multiple themes
SNAPSHOT_THEMES=bubblegum,nocturneVolt,crimsonFury swift run NeoBrutalistSnapshots
```

### Custom Output Directory

```bash
SNAPSHOT_OUTPUT=/path/to/output swift run NeoBrutalistSnapshots
```

### Limit to Light or Dark

```bash
# Only light mode
SNAPSHOT_COLOR_SCHEMES=light swift run NeoBrutalistSnapshots

# Both (explicit)
SNAPSHOT_COLOR_SCHEMES=light,dark swift run NeoBrutalistSnapshots
```

## Output Structure

Snapshots are organized by theme and color scheme:

```
Snapshots/
├── bubblegum/
│   ├── light/
│   │   ├── buttons@2x.png
│   │   └── ...
│   └── dark/
│       └── ...
├── daybreakPlaza/
│   └── ...
└── nocturneVolt/
    └── ...
```

## What Gets Tested

The snapshot system tests the following components:

1. **Buttons** - Compact, regular, prominent, and disabled states
2. **Cards** - Simple and highlighted cards with various configurations
3. **Toggles** - All three sizes (compact, regular, large) in on/off states
4. **Badges** - Active and inactive states with various icon placements
5. **Surfaces** - Different accent edges and highlighting
6. **Sliders** - With and without labels, various values
7. **Text Fields** - Empty and filled states
8. **Disclosure Groups** - Collapsed and expanded states
9. **Menus** - Button menus with various items
10. **Backgrounds** - Background with grid overlay

## Use Cases

### Visual Regression Testing

Run snapshot generation before and after changes:

```bash
# Before changes
swift run NeoBrutalistSnapshots
mv Snapshots Snapshots_before

# Make your changes...

# After changes
swift run NeoBrutalistSnapshots
mv Snapshots Snapshots_after

# Compare with your favorite image diff tool
```

### Theme Development

When creating a new theme, generate snapshots to see how it looks across all components:

```bash
# Edit NeoBrutalistTheme.swift to add your theme
# Then generate snapshots for it
SNAPSHOT_THEMES=myNewTheme swift run NeoBrutalistSnapshots
```

### CI/CD Integration

Add to your CI pipeline to catch visual regressions:

```yaml
- name: Generate Snapshots
  run: swift run NeoBrutalistSnapshots
- name: Upload Snapshots
  uses: actions/upload-artifact@v3
  with:
    name: snapshots
    path: Snapshots/
```

## Adding New Test Cases

To add a new component test case, edit `Examples/NeoBrutalistSnapshots/ComponentTestCases.swift`:

```swift
static var myComponentTestCase: SnapshotTestCase {
    SnapshotTestCase(
        name: "my-component",
        config: .standard,  // or .compact, .wide
        view: AnyView(
            MyComponent()
                .padding()
        )
    )
}
```

Then add it to the `all` array in `ComponentTestCases`.

## Configuration Options

### SnapshotConfig

Three predefined configurations are available:

- **standard**: 400x300 @ 2x scale
- **compact**: 300x200 @ 2x scale
- **wide**: 600x300 @ 2x scale

You can create custom configurations:

```swift
let config = SnapshotConfig(
    size: CGSize(width: 500, height: 400),
    scale: 2.0,
    theme: .bubblegum,
    colorScheme: .light // or .dark
)
```

## Tips

1. **Review Snapshots**: Always review generated snapshots visually to ensure they match expectations
2. **Version Control**: Consider committing reference snapshots to track visual changes over time
3. **CI Artifacts**: Save snapshots as artifacts in CI for easy review in pull requests
4. **Image Comparison**: Use tools like ImageMagick's `compare` command to highlight differences:
   ```bash
   compare before.png after.png diff.png
   ```

## Troubleshooting

### Blank or Missing Snapshots

If snapshots appear blank:
- Ensure views have explicit sizes or proper layouts
- Check that themes are loading correctly
- Verify `@MainActor` is being respected for SwiftUI views

### Memory Issues

If generating many snapshots causes memory issues:
- Generate snapshots theme-by-theme
- Reduce the scale factor in SnapshotConfig
- Generate snapshots for specific components only

## Architecture

The snapshot system consists of:

1. **SnapshotRenderer**: Uses SwiftUI's `ImageRenderer` to convert views to images
2. **ComponentTestCases**: Defines what components and states to test
3. **SnapshotApp**: Main executable that orchestrates the snapshot generation
4. **SnapshotConfig**: Configuration for size, scale, theme, and color scheme

All snapshot code lives in `Examples/NeoBrutalistSnapshots/`.
