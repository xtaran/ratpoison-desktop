#!/bin/sh

DIR=/sys/devices/system/cpu/cpu0/cpufreq
if [ -z "$1" ]; then
    echo Parameter needed
    exit 1
fi

sudo cpufreq-set -g userspace
sudo cpufreq-set -f `xargs -n 1 -a $DIR/scaling_available_frequencies | grep ^"$1" | head -1`
