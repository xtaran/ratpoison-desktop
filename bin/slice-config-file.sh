#!/bin/sh

BIN=$(dirname $0)
TR="tr a-z- A-Z_"
INPUT="$1"
shift

. $BIN/../common/commons.sh

HOSTNAME=`( test -z "$2" && uname -n || echo $2 ) | $TR`
DIST=`( test -z "$3" && lsb_release -cs || echo $3 ) | $TR`
ETHERNET=`( test -z "$4" && \
    /sbin/ifconfig 2>&1 | \
    sed -e 's/%/_/g; s/^\([a-z0-9]*\):/\n\1/g' | \
    awk '!/^$/ {printf $0}; /^$/ {print}' | \
    egrep 'Ethernet' | \
    awk '{print $1}' || echo $4 ) | $TR`
BATTERY=`( test -z "$5" && wh acpi && \
    acpi -V | \
    awk -F'[ :]' '/^Battery/ {print $1$2}' | \
    sort -u || echo $5 ) | $TR`
CORE=`test -z "$6" && \
    awk '/^processor/ {print "CORE"$3}' /proc/cpuinfo | \
    tail -1 || echo $6`

$BIN/simple-slice.pl $HOSTNAME $DIST $ETHERNET $BATTERY $CORE $@ < "$INPUT"
