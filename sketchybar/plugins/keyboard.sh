#!/bin/bash
LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null \
  | grep 'KeyboardLayout Name' | head -1 \
  | sed 's/.*= "\(.*\)";/\1/' | sed 's/.*= //' | tr -d '";')

[ -z "$LAYOUT" ] && LAYOUT="EN"
[ "$LAYOUT" = "US" ] && LAYOUT="ABC"
sketchybar --set "$NAME" icon.drawing=off label="$LAYOUT"
