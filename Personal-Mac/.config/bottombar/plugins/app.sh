#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

PROCESS=$(lsappinfo | grep "pid" | wc -l | tr -d ' ')

# Fall back to 0 if the count came back empty or non-numeric
case $PROCESS in
'' | *[!0-9]*) PROCESS=0 ;;
esac

COLOR=$COLOR_BACKGROUND
if [ "$PROCESS" -ge 90 ]; then
	BCOLOR=$COLOR_RED_BRIGHT
elif [ "$PROCESS" -ge 70 ]; then
	BCOLOR=$COLOR_ORANGE_BRIGHT
elif [ "$PROCESS" -ge 50 ]; then
	BCOLOR=$COLOR_YELLOW_BRIGHT
else
	BCOLOR=$COLOR_DEFAULT
fi

bottombar --set $NAME icon.color=$COLOR background.color=$BCOLOR label="$PROCESS" label.color=$COLOR
