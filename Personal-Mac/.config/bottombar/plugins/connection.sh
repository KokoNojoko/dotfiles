#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

# Established TCP connections, excluding loopback. netstat lists both ends of a
# local connection, so unfiltered loopback (a dev server talking to local
# Postgres, say) would be counted twice.
CONN=$(netstat -an 2>/dev/null | awk '
	$NF == "ESTABLISHED" && $4 !~ /^127\.0\.0\.1\./ && $4 !~ /^::1\./ { n++ }
	END { print n+0 }')

# Fall back to 0 if the count came back empty or non-numeric
case $CONN in
'' | *[!0-9]*) CONN=0 ;;
esac

COLOR=$COLOR_BACKGROUND
if [ "$CONN" -ge 1000 ]; then
	BCOLOR=$COLOR_RED_BRIGHT
elif [ "$CONN" -ge 30 ]; then
	BCOLOR=$COLOR_ORANGE_BRIGHT
elif [ "$CONN" -ge 20 ]; then
	BCOLOR=$COLOR_YELLOW_BRIGHT
else
	BCOLOR=$COLOR_DEFAULT
fi

bottombar --set $NAME icon.color=$COLOR background.color=$BCOLOR label="$CONN" label.color=$COLOR
