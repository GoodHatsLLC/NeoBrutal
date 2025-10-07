# NeoBrutalistWindowSnapshots

Automated window snapshot tool for capturing full macOS window screenshots of NeoBrutalist UI components with custom chrome, shadows, and theme styling.

## Overview

This tool complements the standard `NeoBrutalistSnapshots` by capturing complete window implementations including:
- Custom window chrome (`NeoBrutalistWindowChrome`)
- Window borders and shadows
- Window buttons and accessories
- Full-window component layouts

## Usage

### Quick Start

```bash
# Capture windows for all themes
swift run NeoBrutalistWindowSnapshots

# Capture for specific themes only
SNAPSHOT_THEMES=bubblegum,crimsonFury swift run NeoBrutalistWindowSnapshots

# Use custom output directory
SNAPSHOT_OUTPUT=./CustomSnapshots swift run NeoBrutalistWindowSnapshots
```

### Using the Capture Script

The `capture_windows.sh` script provides an automated workflow:

```bash
# Capture all windows for all themes
./Examples/NeoBrutalistWindowSnapshots/capture_windows.sh

# Capture specific themes
SNAPSHOT_THEMES=bubblegum ./Examples/NeoBrutalistWindowSnapshots/capture_windows.sh
```

### Manual Window Capture

You can also run the window display app manually and capture with your preferred tool:

```bash
# Launch window for 30 seconds
.build/debug/NeoBrutalistWindowSnapshots bubblegum with-content "My Window" "Subtitle" --timeout=30

# In another terminal, use screencapture or any screenshot tool
screencapture -o -w output.png
```

## Architecture

### Window Display App

The `NeoBrutalistWindowSnapshots` executable displays a single window based on command-line arguments:

```bash
NeoBrutalistWindowSnapshots <theme> <window-type> <title> [subtitle] [--timeout=seconds]
```

**Arguments:**
- `theme`: Theme name (bubblegum, daybreakPlaza, nocturneVolt, etc.)
- `window-type`: Window configuration to display:
  - `simple`: Basic window with text
  - `with-content`: Window with card, buttons, and content
  - `with-subtitle`: Window with subtitle badge
- `title`: Window title text
- `subtitle`: Optional subtitle text (can be empty string)
- `--timeout`: How long to display window before exiting (default: 10 seconds)

### Window Types

**Simple Window**
- Basic window with centered title text
- Demonstrates minimal window chrome
- Size: 400×300

**Window With Content**
- Full-featured window with components
- Includes NeoBrutalistCard and buttons
- Demonstrates real-world layout patterns
- Size: 500×400

**Window With Subtitle**
- Window with subtitle badge in chrome
- Shows accessory view integration
- Size: 450×250

## Output

Snapshots are saved to `./Snapshots/` (or `$SNAPSHOT_OUTPUT`) organized by theme:

```
Snapshots/
├── bubblegum/
│   ├── window-simple@2x.png
│   ├── window-with-content@2x.png
│   └── window-with-subtitle@2x.png
├── crimsonFury/
│   ├── ...
└── ...
```

All images are captured at 2x resolution for Retina displays.

## Integration with Testing

### Visual Regression Testing

Use captured snapshots for visual regression testing:

```bash
# Capture baseline snapshots
SNAPSHOT_OUTPUT=./test/baseline swift run NeoBrutalistWindowSnapshots

# After changes, capture new snapshots
SNAPSHOT_OUTPUT=./test/current swift run NeoBrutalistWindowSnapshots

# Compare with your preferred diff tool
compare ./test/baseline/bubblegum/ ./test/current/bubblegum/
```

### CI/CD Integration

Add to your workflow:

```yaml
- name: Generate Window Snapshots
  run: swift run NeoBrutalistWindowSnapshots

- name: Upload Snapshots
  uses: actions/upload-artifact@v3
  with:
    name: window-snapshots
    path: ./Snapshots/
```

## Customization

### Adding New Window Types

Edit `main.swift` and add a new case to the `createWindow` switch statement:

```swift
case "my-custom-window":
    content = AnyView(
        MyCustomView()
            .frame(width: 600, height: 500)
    )
```

Then update the capture script to include the new window type:

```bash
WINDOWS=(
    # ...existing windows...
    "my-custom-window|My Custom Window|"
)
```

### Modifying Window Styling

Window styling is controlled by the theme's window properties:
- `windowRadius`: Corner radius
- `windowBorder`: Border width
- `windowShadowOffset`: Shadow offset
- `windowButtonSize`: Chrome button size

## Troubleshooting

**Windows close immediately**
- The app requires a proper SwiftUI scene to stay alive
- Use `WindowGroup` instead of `Settings` scene

**Capture fails**
- macOS screen recording permissions may be required for some capture methods
- Try using `screencapture -w` for interactive window selection
- Ensure the app is still running (hasn't timed out)

**App doesn't appear in window list**
- Wait a few seconds after launch for the window to fully render
- Check if the process is running: `ps aux | grep NeoBrutalistWindowSnapshots`

## See Also

- [NeoBrutalistSnapshots](../NeoBrutalistSnapshots/) - Component-level snapshot tool
- [SNAPSHOT_TESTING.md](../../SNAPSHOT_TESTING.md) - Visual testing documentation
- [CLAUDE.md](../../CLAUDE.md) - Project architecture guide
