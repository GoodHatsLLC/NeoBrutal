# NeoBrutal Snapshot Testing

Automated visual regression testing for NeoBrutalUI components.

## Overview

This target generates PNG snapshots of all UI components across different themes. It uses SwiftUI's `ImageRenderer` to render views at specific sizes and saves them as high-resolution images.

## Running

```bash
# From repo root
swift run NeoBrutalSnapshots

# With specific themes
SNAPSHOT_THEMES=bubblegum,nocturneVolt swift run NeoBrutalSnapshots

# Custom output
SNAPSHOT_OUTPUT=/path/to/output swift run NeoBrutalSnapshots
```

## Files

- **SnapshotApp.swift**: Main entry point, orchestrates snapshot generation
- **SnapshotRenderer.swift**: Image rendering logic using `ImageRenderer`
- **ComponentTestCases.swift**: Defines what components and states to snapshot

## Adding New Test Cases

1. Create a new static property in `ComponentTestCases`:

```swift
static var myNewTestCase: SnapshotTestCase {
    SnapshotTestCase(
        name: "my-component",
        config: .standard,  // .compact, .wide, or custom
        view: AnyView(
            VStack {
                // Your component in various states
                MyComponent(state: .default)
                MyComponent(state: .active)
                MyComponent(state: .disabled)
            }
            .padding()
        )
    )
}
```

2. Add it to the `all` array:

```swift
static var all: [SnapshotTestCase] {
    [
        // ... existing cases
        myNewTestCase
    ]
}
```

## Configuration

Three predefined sizes:
- **standard**: 400x300 @ 2x
- **compact**: 300x200 @ 2x
- **wide**: 600x300 @ 2x

Custom configurations:
```swift
SnapshotConfig(
    size: CGSize(width: 500, height: 400),
    scale: 2.0,
    theme: .bubblegum,
    colorScheme: .light // or .dark
)
```

## Environment Variables

- `SNAPSHOT_OUTPUT`: Output directory path (default: `./Snapshots`)
- `SNAPSHOT_THEMES`: Comma-separated theme names (default: all themes)
- `SNAPSHOT_COLOR_SCHEMES`: Comma-separated list of color schemes (`light`, `dark`; default: both)

Available theme names:
- `bubblegum`
- `daybreakPlaza` or `daybreak`
- `nocturneVolt` or `nocturne`
- `ultravioletCargo` or `ultraviolet`
- `desert`
- `jungle`
- `crimsonFury` or `crimson`

## Output

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
└── ...
```

## Tips

1. **Keep test cases focused**: Each test case should show a specific component or feature
2. **Use representative states**: Include common states like default, hover, disabled, active
3. **Consistent sizing**: Use predefined configs when possible for consistency
4. **Padding matters**: Add `.padding()` to prevent clipping
5. **Test edge cases**: Include unusual sizes, long text, edge values

## Troubleshooting

**Blank images**: Ensure views have explicit sizes or layouts
**Missing snapshots**: Check that ComponentTestCases.all includes your test case
**Theme not found**: Verify theme name matches themeByName() switch cases
**Memory issues**: Test fewer themes at once or reduce scale

## Integration

### Git
Add to `.gitignore`:
```
Snapshots/
```

### CI/CD Example
```yaml
- name: Generate Snapshots
  run: swift run NeoBrutalSnapshots
- name: Upload Artifacts
  uses: actions/upload-artifact@v3
  with:
    name: snapshots
    path: Snapshots/
```

### Comparison Script
```bash
#!/bin/bash
# Compare snapshots before/after changes

# Before
swift run NeoBrutalSnapshots
mv Snapshots Snapshots_before

# Make changes...

# After
swift run NeoBrutalSnapshots
mv Snapshots Snapshots_after

# Compare
for theme in Snapshots_before/*; do
  theme_name=$(basename "$theme")
  echo "Comparing $theme_name..."
  for img in "$theme"/*.png; do
    file=$(basename "$img")
    compare "$img" "Snapshots_after/$theme_name/$file" \
      "Diff/$theme_name/$file" 2>/dev/null || true
  done
done
```
