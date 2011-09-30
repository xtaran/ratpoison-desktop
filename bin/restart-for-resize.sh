#!/bin/sh

export RP=$(dirname "$0")/..

. $RP/common/commons.sh

killall -INT i3status xmobar

start_bar &
