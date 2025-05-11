#!/bin/bash

# Ensure DISPLAY and XAUTHORITY are set
export DISPLAY=:0
export XAUTHORITY="$HOME/.Xauthority"

# Absolute paths to avoid env issues
BSPC="/usr/bin/bspc"
XDOTOOL="/usr/bin/xdotool"

# Get focused window ID
WID=$($BSPC query -N -n focused)
[ -z "$WID" ] && exit 1

# Get geometry
eval $($XDOTOOL getwindowgeometry --shell "$WID") || exit 1

# Move mouse to center
$XDOTOOL mousemove --window "$WID" $((WIDTH / 2)) $((HEIGHT / 2))

