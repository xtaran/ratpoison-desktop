#!/bin/sh 

INTERNAL="$(xrandr | fgrep connected | egrep    '^(eDP-?1|LVDS-?1)' | awk '{print $1}')"
EXTERNAL="$(xrandr | fgrep connected | egrep -v '^(eDP-?1|LVDS-?1)' | awk '{print $1}')"

for output in $INTERNAL; do
    xrandr --output "$output" --auto
done
for output in $EXTERNAL; do
    xrandr --output "$output" --off
done
