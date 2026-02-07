#!/usr/bin/env bash

COLOR="$ORANGE"

sketchybar --add item music left \
    --set music \
    icon="" \
    icon.color="$COLOR" \
    icon.padding_left=10 \
    label.color="$COLOR" \
    label.padding_right=10 \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COLOR" \
    background.color="$BAR_COLOR" \
    background.drawing=on \
    drawing=off \
    update_freq=3 \
    script="$PLUGIN_DIR/music.sh"