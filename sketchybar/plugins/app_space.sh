#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

SID=$(echo "$NAME" | cut -d'.' -f2)

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  SELECTED=on
else
  SELECTED=off
fi

sketchybar --set $NAME background.drawing=$SELECTED \
  icon.highlight=$SELECTED \
  label.highlight=$SELECTED

for i in "${!ICONS_SPACE[@]}"
do
  sid=$((i+1))
  LABEL=""

  APPS=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null)

  if [[ -n "$APPS" ]]; then
    APPS_ARR=()
    while IFS= read -r line; do APPS_ARR+=("$line"); done <<< "$APPS"

    LENGTH=${#APPS_ARR[@]}
    for j in "${!APPS_ARR[@]}"
    do
      APP=$(echo "${APPS_ARR[j]}" | sed 's/"//g')
      ICON=$("$HOME/.config/sketchybar/plugins/app_icon.sh" "$APP" "")
      LABEL+=" $ICON "
      if [[ $j < $((LENGTH-1)) ]]; then
        LABEL+=" "
      fi
    done
  fi
  sketchybar --set space.$sid label="$LABEL"
done
