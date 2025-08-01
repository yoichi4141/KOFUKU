#!/bin/bash

# KOFUKU iPhone Simulator Runner
# Usage: ./scripts/run_iphone.sh

echo "🚀 Starting KOFUKU on iPhone 16 Pro..."

# iPhone 16 Pro Device ID
DEVICE_ID="145EF60C-5EE2-426A-A567-615861831EC9"

# Check if iPhone simulator is running
if xcrun simctl list devices | grep "$DEVICE_ID" | grep -q "Booted"; then
    echo "✅ iPhone 16 Pro is already running"
else
    echo "📱 Starting iPhone 16 Pro simulator..."
    xcrun simctl boot "$DEVICE_ID"
    sleep 5
fi

# Run Flutter app
echo "🎨 Launching KOFUKU..."
flutter run -d "$DEVICE_ID" 