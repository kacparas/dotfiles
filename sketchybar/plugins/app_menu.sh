#!/bin/bash

ACTION="$1"
INDEX="$2"
STATE_FILE="/tmp/sketchybar_app_menu"

case "$ACTION" in
  toggle)
    PROC=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' 2>/dev/null)

    # Get menu bar items as pipe-separated string
    ITEMS_RAW=$(osascript -e "
      tell application \"System Events\"
        tell process \"$PROC\"
          set itemNames to name of menu bar items of menu bar 1
          set AppleScript's text item delimiters to \"|\"
          set output to itemNames as text
          set AppleScript's text item delimiters to \"\"
          return output
        end tell
      end tell
    " 2>/dev/null)

    # Save proc + items for click handler
    echo "$PROC" > "$STATE_FILE"
    echo "$ITEMS_RAW" >> "$STATE_FILE"

    # Populate slots
    IFS='|' read -ra ITEMS <<< "$ITEMS_RAW"
    for i in $(seq 0 9); do
      if [ $i -lt ${#ITEMS[@]} ]; then
        sketchybar --set "menu.$i" label="${ITEMS[$i]}" drawing=on
      else
        sketchybar --set "menu.$i" drawing=off
      fi
    done

    sketchybar --set app_name popup.drawing=toggle
    ;;

  click)
    PROC=$(sed -n '1p' "$STATE_FILE")
    ITEMS_RAW=$(sed -n '2p' "$STATE_FILE")
    IFS='|' read -ra ITEMS <<< "$ITEMS_RAW"
    ITEM="${ITEMS[$INDEX]}"

    sketchybar --set app_name popup.drawing=off

    osascript -e "
      tell application \"System Events\"
        tell process \"$PROC\"
          click menu bar item \"$ITEM\" of menu bar 1
        end tell
      end tell
    " 2>/dev/null
    ;;
esac
