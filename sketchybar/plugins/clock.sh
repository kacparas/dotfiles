#!/bin/bash
WEEKDAY=$(date '+%a')
WEEK=$(date '+%V')
DATE=$(date '+%d %b')
TIME=$(date '+%H:%M')
sketchybar --set "$NAME" label="${WEEKDAY}  W${WEEK}  ${DATE}  ${TIME}"
