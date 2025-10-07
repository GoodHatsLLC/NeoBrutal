#!/bin/bash

# Window snapshot orchestrator using Peekaboo MCP
# This script launches the window display app and captures screenshots

set -e

# Configuration
OUTPUT_DIR="${SNAPSHOT_OUTPUT:-./Snapshots}"
THEMES="${SNAPSHOT_THEMES:-bubblegum,daybreakPlaza,nocturneVolt,ultravioletCargo,desert,jungle,crimsonFury}"
APP_PATH=".build/debug/NeoBrutalistWindowSnapshots"

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

        # Launch the window app in background with stdin pipe
        "$APP_PATH" "$theme" "$window_type" "$title" "$subtitle" < /dev/null &
        APP_PID=$!

        # Wait for window to appear and render
        sleep 1.5

        # Capture using macOS screencapture (fallback if Peekaboo not available)
        # This captures the frontmost window
        screencapture -o -w "$output_path" 2>/dev/null || {
            echo "  ⚠️  Failed to capture $filename"
            kill $APP_PID 2>/dev/null || true
            continue
        }

        # Kill the app
        kill $APP_PID 2>/dev/null || true
        wait $APP_PID 2>/dev/null || true

        echo "  ✅ Saved: $theme/$filename"

        # Small delay between captures
        sleep 0.3
    done
done

echo "✅ Window snapshot generation complete!"
echo "📁 Snapshots saved to: $OUTPUT_DIR"
