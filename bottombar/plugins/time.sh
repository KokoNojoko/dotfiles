#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

HOUR=$(date '+%H')

case $HOUR in
    0[5-9])
        BCOLOR=$COLOR_CYAN_BRIGHT
        COLOR=$COLOR_BACKGROUND
        ;;
    1[0-1])
        BCOLOR=$COLOR_BLUE_BRIGHT
        COLOR=$COLOR_BACKGROUND
        ;;
    1[2-6])
        BCOLOR=$COLOR_ORANGE_BRIGHT
        COLOR=$COLOR_BACKGROUND
        ;;
    1[7-8])
        BCOLOR=$COLOR_RED_BRIGHT
        COLOR=$COLOR_BACKGROUND
        ;;
    19 | 2[0-3])
        BCOLOR=$COLOR_BLACK
        COLOR=$COLOR_DEFAULT
        ;;
    0[0-4])
        BCOLOR=$COLOR_BLACK
        COLOR=$COLOR_DEFAULT
        ;;
    *)
        BCOLOR=$COLOR_DEFAULT
        COLOR=$COLOR_BACKGROUND
        ;;
esac

bottombar --set $NAME label="$(date '+%I:%M %p')" background.color=$BCOLOR icon.color=$COLOR label.color=$COLOR
