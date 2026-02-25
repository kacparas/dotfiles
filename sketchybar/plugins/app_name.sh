#!/bin/bash

PROC="${APP_NAME:-$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)}"

sketchybar --set "$NAME" label="${PROC:-—}"
