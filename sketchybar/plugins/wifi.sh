#!/bin/sh

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"

WIFI=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Current Network Information:/{getline; gsub(/^ *| *:$/,""); if($0 !~ /Network Type/) print; exit}')
IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
VPN=$(scutil --nwi | grep -m1 'VPN' | awk '{ print $4 }')

if [[ $VPN != "" ]]; then
  COLOR=$COLOR_CYAN_BRIGHT
  ICON=$ICON_VPN
  LABEL=${WIFI:-"VPN"}
elif [[ -n "$WIFI" ]]; then
  COLOR=$COLOR_BLUE_BRIGHT
  ICON=$ICON_WIFI
  LABEL="$WIFI"
elif [[ -n "$IP_ADDRESS" ]]; then
  COLOR=$COLOR_DEFAULT
  ICON=$ICON_WIFI
  LABEL="on"
else
  COLOR=$COLOR_DEFAULT
  ICON=$ICON_WIFI_OFF
  LABEL="off"
fi

sketchybar --set $NAME background.color=$COLOR icon=$ICON label="$LABEL"
