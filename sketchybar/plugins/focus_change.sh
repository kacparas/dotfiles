#!/bin/bash
APP=$(/opt/homebrew/bin/aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)
/opt/homebrew/bin/sketchybar --trigger window_focus APP_NAME="$APP"
