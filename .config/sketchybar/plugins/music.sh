#!/usr/bin/env bash

STATE=$(osascript -e 'tell application "Music" to get player state' 2>/dev/null)

if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Music" to get name of current track' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Music" to get artist of current track' 2>/dev/null)
    sketchybar --set "$NAME" label="$TRACK - $ARTIST" drawing=on
else
    sketchybar --set "$NAME" drawing=off
fi
