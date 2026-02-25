#!/bin/bash

# Get the default audio output device name and transport
OUTPUT=$(system_profiler SPAudioDataType 2>/dev/null | python3 -c "
import sys, re

text = sys.stdin.read()
# Split into device blocks
blocks = re.split(r'\n(?=        \S)', text)

for block in blocks:
    if 'Default Output Device: Yes' in block:
        transport = re.search(r'Transport:\s+(\S+)', block)
        source = re.search(r'Output Source:\s+(.+)', block)
        transport = transport.group(1) if transport else ''
        source = source.group(1).strip() if source else ''
        print(f'{transport}|{source}')
        break
")

TRANSPORT=$(echo "$OUTPUT" | cut -d'|' -f1)
SOURCE=$(echo "$OUTPUT" | cut -d'|' -f2)

VOLUME=$(osascript -e "output volume of (get volume settings)" 2>/dev/null)

if echo "$SOURCE $TRANSPORT" | grep -qi "airpods"; then
  ICON=$(printf '\xf3\xb1\xa1\x8f')
  sketchybar --set "$NAME" icon="$ICON" icon.font="JetBrainsMono Nerd Font Mono:Regular:18.0" label=""
elif [ "$TRANSPORT" = "Bluetooth" ]; then
  sketchybar --set "$NAME" icon="󰋋" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label=""
elif [ "$TRANSPORT" = "HDMI" ] || [ "$TRANSPORT" = "DisplayPort" ]; then
  sketchybar --set "$NAME" icon="󰡁" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label=""
elif [ "$VOLUME" = "0" ]; then
  sketchybar --set "$NAME" icon="󰝟" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label=""
else
  sketchybar --set "$NAME" icon="󰕾" icon.font="JetBrainsMono Nerd Font Mono:Regular:15.0" label=""
fi
