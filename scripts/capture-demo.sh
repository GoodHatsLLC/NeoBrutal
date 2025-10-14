#!/bin/bash

# Script to capture a screenshot of NeoBrutalDemo app
# Usage: ./capture-demo.sh [output-path]
#
# Arguments:
#   output-path: Optional path for the screenshot (default: ./screenshot.png)

set -e

# Configuration
OUTPUT_PATH="${1:-./screenshot.png}"
APP_NAME="NeoBrutalDemo"
MAX_WAIT_SECONDS=30
CHECK_INTERVAL=1

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting NeoBrutalDemo screenshot automation...${NC}"

# Change to the project root (parent of scripts directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# Launch the demo app in the background
echo -e "${YELLOW}Launching $APP_NAME...${NC}"
swift run "$APP_NAME" > /dev/null 2>&1 &
APP_PID=$!

# Function to cleanup on exit
cleanup() {
    if [ ! -z "$APP_PID" ] && kill -0 "$APP_PID" 2>/dev/null; then
        echo -e "${YELLOW}Cleaning up: terminating $APP_NAME (PID: $APP_PID)...${NC}"
        kill "$APP_PID" 2>/dev/null || true
        # Wait a moment for graceful shutdown
        sleep 1
        # Force kill if still running
        kill -9 "$APP_PID" 2>/dev/null || true
    fi
}

# Set trap to cleanup on script exit
trap cleanup EXIT INT TERM

# Wait for the app to appear on screen
echo -e "${YELLOW}Waiting for $APP_NAME to appear (max ${MAX_WAIT_SECONDS}s)...${NC}"
elapsed=0
while [ $elapsed -lt $MAX_WAIT_SECONDS ]; do
    # Try to take a screenshot - it will succeed once the app is visible
    if "$SCRIPT_DIR/node_modules/@steipete/peekaboo-mcp/peekaboo" image --app "$APP_NAME" --path "$OUTPUT_PATH" 2>/dev/null; then
        echo -e "${GREEN}✓ Screenshot captured successfully: $OUTPUT_PATH${NC}"

        # Get file size for confirmation
        if [ -f "$OUTPUT_PATH" ]; then
            FILE_SIZE=$(du -h "$OUTPUT_PATH" | cut -f1)
            echo -e "${GREEN}  File size: $FILE_SIZE${NC}"
        fi

        exit 0
    fi

    # Check if the app process is still running
    if ! kill -0 "$APP_PID" 2>/dev/null; then
        echo -e "${RED}✗ Error: $APP_NAME process terminated unexpectedly${NC}"
        exit 1
    fi

    sleep $CHECK_INTERVAL
    elapsed=$((elapsed + CHECK_INTERVAL))

    # Show progress
    if [ $((elapsed % 5)) -eq 0 ]; then
        echo -e "${YELLOW}  Still waiting... (${elapsed}s elapsed)${NC}"
    fi
done

echo -e "${RED}✗ Timeout: $APP_NAME did not appear within ${MAX_WAIT_SECONDS}s${NC}"
exit 1
