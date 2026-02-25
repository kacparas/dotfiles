#!/bin/bash
SSID=$(networksetup -getairportnetwork en0 2>/dev/null | sed 's/Current Wi-Fi Network: //')

if [[ "$SSID" == *"not associated"* ]] || [ -z "$SSID" ]; then
  # Check if we have internet anyway (hotspot via USB/BT)
  if ping -c1 -t1 1.1.1.1 &>/dev/null 2>&1; then
    sketchybar --set "$NAME" icon="󱘖" icon.font="JetBrainsMono Nerd Font Mono:Regular:18.0" label=""
  else
    sketchybar --set "$NAME" icon="󰤮" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label=""
  fi
else
  sketchybar --set "$NAME" icon="󰤨" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label="$SSID"
fi
