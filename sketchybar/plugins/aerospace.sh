#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
HAS_WINDOWS=$(aerospace list-windows --workspace "$1" 2>/dev/null | grep -c '.')

if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" label.color=0xff88c0d0 label.font="SF Pro:Bold:14.0" drawing=on
elif [ "$HAS_WINDOWS" -gt 0 ]; then
  sketchybar --set "$NAME" label.color=0xff6b737d label.font="SF Pro:Regular:14.0" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
