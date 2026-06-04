#!/bin/bash

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

if [ -n "$INFO" ]; then
  STATE="$(echo "$INFO" | jq -r '.state')"
  TITLE="$(echo "$INFO" | jq -r '.title')"
  ARTIST="$(echo "$INFO" | jq -r '.artist')"
  APP="$(echo "$INFO" | jq -r '.app')"
  if [ "$APP" != "Music" ] && [ "$APP" != "" ]; then
    exit 0
  fi
else
  STATE=$(osascript -e 'tell application "Music" to get player state as string' 2>/dev/null)
  TITLE=$(osascript -e 'tell application "Music" to get name of current track' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Music" to get artist of current track' 2>/dev/null)
fi

if [ "$STATE" = "playing" ]; then
  sketchybar --set music.title label="${TITLE} - ${ARTIST}" \
             --set music.icon icon=$ICON_MUSIC icon.color=$COLOR_BACKGROUND background.color=$COLOR_RED_BRIGHT
elif [ "$STATE" = "paused" ]; then
  sketchybar --set music.title label="${TITLE} - ${ARTIST}" \
             --set music.icon icon=$ICON_MUSIC icon.color=$COLOR_DEFAULT background.color=$COLOR_SURFACE1
else
  sketchybar --set music.title label="" \
             --set music.icon icon=$ICON_MUSIC icon.color=$COLOR_DEFAULT background.color=$COLOR_SURFACE1
fi
