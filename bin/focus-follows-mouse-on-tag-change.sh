#!/bin/sh

# Regain focus on the window under the mouse by moving the mouse off
# the window and back in
COORD="`xdotool getmouselocation | awk -F'[: ]' '{print $2" "$4}'`"
xdotool mousemove 0 0
xdotool mousemove $COORD
