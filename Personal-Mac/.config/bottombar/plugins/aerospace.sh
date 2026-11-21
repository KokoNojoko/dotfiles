#!/bin/bash

WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)

if [ -z "$WORKSPACE" ]; then
  WORKSPACE="?"
fi

bottombar --set $NAME label="$WORKSPACE"
