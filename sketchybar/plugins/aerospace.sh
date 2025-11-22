#!/bin/bash
if [ "$1" = "$(aerospace list-workspaces --focused)" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi
