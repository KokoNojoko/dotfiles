#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

# Rectangle doesn't have CLI for space switching, using macOS native approach
SPACE_CLICK_SCRIPT=""

if [ "$SELECTED" = "true" ]; then
    sketchybar --animate tanh 5 --set "$NAME" \
        icon.color="$RED" \
        icon="${SPACE_ICONS[$SID - 1]}" \
        click_script="$SPACE_CLICK_SCRIPT"
else
    sketchybar --animate tanh 5 --set "$NAME" \
        icon.color="$COMMENT" \
        icon="${SPACE_ICONS[$SID - 1]}" \
        click_script="$SPACE_CLICK_SCRIPT"
fi
