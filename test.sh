#!/bin/bash
set -e

# Ensure we are in the directory where the script is located
cd "$(dirname "$0")"

echo "🚀 Running swift test for River..."
swift test --package-path River

echo "🚀 Running xcodebuild test for RiverEditor..."
# We use -quiet to keep the output manageable, but it will still show errors if they occur.
xcodebuild test -project RiverEditor/RiverEditor.xcodeproj -scheme RiverEditor -destination 'platform=macOS' -quiet
