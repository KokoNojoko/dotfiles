#!/bin/bash

if [ -n "$INFO" ]; then
  LABEL="$INFO"
else
  LABEL=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null | head -1)
fi

if [[ -z "$LABEL" ]]; then
  LABEL="Desktop"
fi

sketchybar --set $NAME label="$LABEL"
