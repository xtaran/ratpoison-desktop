#!/bin/sh

COORD="`xdotool getmouselocation | awk -F'[: ]' '{print $2" "$4}'`"
xdotool mousemove 0 0
xdotool mousemove $COORD
