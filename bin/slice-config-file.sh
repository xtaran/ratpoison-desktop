#!/bin/sh

HOSTNAME=`( test -z "$2" && uname -n || echo $2 ) | tr a-z- A-Z_`
DIST=`( test -z "$3" && lsb_release -cs || echo $3 ) | tr a-z- A-Z_`
ETHERNET=`( test -z "$4" && \
    /sbin/ifconfig 2>&1 | \
    sed -e 's/%/_/g; s/^\([a-z0-9]*\):/\n\1/g' | \
    awk '!/^$/ {printf $0}; /^$/ {print}' | \
    egrep 'Ethernet' | \
    awk '{print $1}' || echo $4 ) | tr a-z- A-Z_`

$(dirname $0)/simple-slice.pl $HOSTNAME $DIST $ETHERNET < $1
