#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

BREW=$(brew outdated 2>/dev/null | wc -l | awk '{ print $1 }')
if [[ $BREW == 0 ]]; then
    BCOLOR=$COLOR_BACKGROUND
    COLOR=$COLOR_DEFAULT
else
    BCOLOR=$COLOR_BLUE_BRIGHT
    COLOR=$COLOR_BLACK_BRIGHT
fi
bottombar --set brew label="$BREW" background.color=$BCOLOR icon.color=$COLOR label.color=$COLOR
