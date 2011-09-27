#!/bin/sh

# Define some variables used within this script
export RP=$(dirname "$0")/..
PH=$RP/per-host

# TODO: Refactoring due to code duplication
BG=$HOME/.backgrounds
W=`xwininfo -root | fgrep Width: | awk '{print $2}'`
H=`xwininfo -root | fgrep Height: | awk '{print $2}'`
WT=`expr $W / 6`
HT=`expr $H / 11 - 1`
FONT='-xos4-terminus-medium-r-normal-*-12-120-72-72-c-60-iso10646-1'
export PATH="${PATH}:/sbin:/usr/sbin:${RP}/bin"

# Define some functions
wh() {
    which "$1" > /dev/null
}
whe() {
    wh "$1" && "$@"
}

killall -INT i3status xmobar

# From xsession, too
if [ -r $PH/i3statusrc.`uname -n` ]; then
    i3status -c $PH/i3statusrc.`uname -n`
else
    i3status -c $RP/i3statusrc
fi | if [ -r $PH/xmobarrc.`uname -n` ]; then
    env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $PH/xmobarrc.`uname -n`
else
    env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $RP/xmobarrc
fi &
