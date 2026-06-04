#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

if [ -n "$INFO" ]; then
  LABEL="$INFO"
else
  LABEL=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null | head -1)
fi

case "$LABEL" in
  "Ghostty" | "Terminal" | "kitty") RESULT=$ICON_TERM ;;
  "Finder") RESULT=$ICON_FILE ;;
  "Mail") RESULT=$ICON_MAIL ;;
  "Calendar") RESULT=$ICON_CALENDAR ;;
  "Calculator") RESULT=$ICON_CALC ;;
  "Maps" | "Find My") RESULT=$ICON_MAP ;;
  "WhatsApp" | "WhatsApp Web") RESULT=$ICON_WHATSAPP ;;
  "Messages") RESULT=$ICON_CHAT ;;
  "FaceTime") RESULT=$ICON_VIDEOCHAT ;;
  "Notes" | "TextEdit" | "Stickies") RESULT=$ICON_NOTE ;;
  "Reminders") RESULT=$ICON_LIST ;;
  "Safari") RESULT=$ICON_SAFARI ;;
  "System Settings" | "System Information") RESULT=$ICON_COG ;;
  "Music") RESULT=$ICON_MUSIC ;;
  "Podcasts") RESULT=$ICON_PODCAST ;;
  "TV" | "QuickTime Player" | "VLC") RESULT=$ICON_PLAY ;;
  "Books") RESULT=$ICON_BOOK ;;
  "Neovide") RESULT=$ICON_DEV ;;
  "Activity Monitor") RESULT=$ICON_CHART ;;
  "Disk Utility") RESULT=$ICON_DISK ;;
  "Screenshot" | "Preview") RESULT=$ICON_PREVIEW ;;
  "Passwords") RESULT=$ICON_PASSKEY ;;
  "Notion") RESULT=$ICON_NOTION ;;
  "DBeaver"*) RESULT=$ICON_DATABASE ;;
  "Raycast") RESULT=$ICON_RAYCAST ;;
  "Weather") RESULT=$ICON_WEATHER ;;
  "") RESULT=$ICON_APPLE ;;
  *) RESULT=$ICON_APP ;;
esac

sketchybar --set $NAME icon=$RESULT
