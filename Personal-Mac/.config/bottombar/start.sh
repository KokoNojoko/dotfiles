#!/bin/bash
pkill -9 -x bottombar 2>/dev/null
sleep 1
/usr/local/bin/bottombar --config "$HOME/.config/bottombar/sketchybarrc" &
disown
