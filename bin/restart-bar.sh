#!/bin/sh

export RP=$(dirname "$0")/..

. $RP/common/init.sh

killall -INT i3status xmobar

start_bar &
