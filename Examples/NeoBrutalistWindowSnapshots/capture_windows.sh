#!/bin/bash

# Window snapshot capture script for NeoBrutalistUI
# Captures window components using macOS screencapture

set -e

# Configuration
OUTPUT_DIR="${SNAPSHOT_OUTPUT:-./Snapshots}"
THEMES="${SNAPSHOT_THEMES:-bubblegum,daybreakPlaza,nocturneVolt,ultravioletCargo,desert,jungle,crimsonFury}"
APP_PATH=".build/debug/NeoBrutalistWindowSnapshots"
CAPTURE_DELAY=2.0  # Seconds to wait for window to render

# Build the app first
echo "📦 Building NeoBrutalistWindowSnapshots..."
swift build --product NeoBrutalistWindowSnapshots

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Parse themes
IFS=',' read -ra THEME_ARRAY <<< "$THEMES"

echo "📸 Starting window snapshot generation..."
echo "📋 Testing ${#THEME_ARRAY[@]} theme(s): ${THEMES}"

# Window configurations: type|title|subtitle
WINDOWS=(
    "simple|Window Simple|"
    "with-content|Window With Content|"
    "with-subtitle|Window With Subtitle|Subtitle Text"
)

# Capture each window for each theme
for theme in "${THEME_ARRAY[@]}"; do
    theme=$(echo "$theme" | xargs) # trim whitespace
    echo "🎨 Testing theme: $theme"

    # Create theme directory
    mkdir -p "$OUTPUT_DIR/$theme"

    for window_config in "${WINDOWS[@]}"; do
        IFS='|' read -r window_type title subtitle <<< "$window_config"

        filename="window-${window_type}@2x.png"
        output_path="$OUTPUT_DIR/$theme/$filename"

        echo "  📸 Capturing $window_type..."

        # Launch the window app in background
        "$APP_PATH" "$theme" "$window_type" "$title" "$subtitle" --timeout=10 > /dev/null 2>&1 &
        APP_PID=$!

        # Wait for window to appear and render
        sleep $CAPTURE_DELAY

        # Capture using macOS screencapture (interactive window selection)
        # The -w flag captures a specific window (waits for user click, but we'll use -l with window ID)
        # For now, use -o (no window shadow) and -w (capture window) which captures frontmost
        if screencapture -o -w "$output_path" 2>/dev/null; then
            echo "  ✅ Saved: $theme/$filename"
        else
            echo "  ⚠️  Failed to capture $filename"
        fi

        # Kill the app
        kill $APP_PID 2>/dev/null || true
        wait $APP_PID 2>/dev/null || true

        # Small delay between captures
        sleep 0.5
    done
done

echo ""
echo "✅ Window snapshot generation complete!"
echo "📁 Snapshots saved to: $OUTPUT_DIR"
