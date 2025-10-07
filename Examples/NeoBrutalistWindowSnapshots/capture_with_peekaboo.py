#!/usr/bin/env python3

"""
Window snapshot orchestrator using Peekaboo MCP
This script launches the window display app and captures screenshots using Peekaboo
"""

import subprocess
import time
import os
import sys
import json
from pathlib import Path

# Configuration
OUTPUT_DIR = os.environ.get("SNAPSHOT_OUTPUT", "./Snapshots")
THEMES = os.environ.get("SNAPSHOT_THEMES", "bubblegum,daybreakPlaza,nocturneVolt,ultravioletCargo,desert,jungle,crimsonFury")
APP_PATH = ".build/debug/NeoBrutalistWindowSnapshots"
APP_NAME = "NeoBrutalistWindowSnapshots"

# Window configurations: (type, title, subtitle)
WINDOWS = [
    ("simple", "Window Simple", ""),
    ("with-content", "Window With Content", ""),
    ("with-subtitle", "Window With Subtitle", "Subtitle Text"),
]

def build_app():
    """Build the window display app"""
    print("📦 Building NeoBrutalistWindowSnapshots...")
    subprocess.run(["swift", "build", "--product", "NeoBrutalistWindowSnapshots"], check=True)

def capture_window_with_screencapture(output_path: str, window_id: int = None) -> bool:
    """Capture window using macOS screencapture command"""
    try:
        # Capture the frontmost window
        cmd = ["screencapture", "-o", "-w", output_path]
        result = subprocess.run(cmd, capture_output=True, timeout=5)
        return result.returncode == 0 and os.path.exists(output_path)
    except Exception as e:
        print(f"  ⚠️  screencapture failed: {e}")
        return False

def main():
    # Build the app
    build_app()

    # Create output directory
    Path(OUTPUT_DIR).mkdir(parents=True, exist_ok=True)

    # Parse themes
    themes = [t.strip() for t in THEMES.split(",")]

    print(f"📸 Starting window snapshot generation...")
    print(f"📋 Testing {len(themes)} theme(s): {', '.join(themes)}")

    # Capture each window for each theme
    for theme in themes:
        print(f"🎨 Testing theme: {theme}")

        # Create theme directory
        theme_dir = Path(OUTPUT_DIR) / theme
        theme_dir.mkdir(parents=True, exist_ok=True)

        for window_type, title, subtitle in WINDOWS:
            filename = f"window-{window_type}@2x.png"
            output_path = str(theme_dir / filename)

            # Launch the window app
            cmd = [APP_PATH, theme, window_type, title]
            if subtitle:
                cmd.append(subtitle)

            # Start process with pipe for stdin control
            process = subprocess.Popen(
                cmd,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )

            # Wait for window to appear and render
            time.sleep(2.0)

            # Capture the window
            success = capture_window_with_screencapture(output_path)

            # Kill the app by closing stdin
            try:
                process.stdin.close()
                process.wait(timeout=2)
            except:
                process.kill()
                process.wait()

            if success:
                print(f"  ✅ Saved: {theme}/{filename}")
            else:
                print(f"  ❌ Failed to capture: {theme}/{filename}")

            # Small delay between captures
            time.sleep(0.5)

    print("✅ Window snapshot generation complete!")
    print(f"📁 Snapshots saved to: {OUTPUT_DIR}")

if __name__ == "__main__":
    main()
