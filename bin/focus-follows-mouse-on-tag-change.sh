#!/bin/sh

# Regain focus on the window under the mouse by moving the mouse off
# the window and back in
xdotool getmouselocation | awk -F'[: ]' '{print $2" "$4" "$6}' | while read x y s; do
    echo $x $y $s
    xdotool mousemove --screen $s 2 2
    xdotool mousemove --screen $s $x $y
done
