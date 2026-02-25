#!/bin/bash
BATT=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT" | grep -o '[0-9]*%' | head -1 | tr -d '%')
CHARGING=$(echo "$BATT" | grep -c 'AC Power')

if [ "$CHARGING" -gt 0 ]; then
  ICON="󰂄"
elif [ "${PERCENTAGE:-100}" -le 20 ]; then
  ICON="󰁻"
else
  ICON="󰁹"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
