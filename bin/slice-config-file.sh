#!/bin/sh

HOSTNAME=`( test -z "$2" && uname -n || echo $2 ) | tr a-z- A-Z_`
DIST=`( test -z "$3" && lsb_release -cs || echo $3 ) | tr a-z- A-Z_`

$(dirname $0)/simple-slice.pl $HOSTNAME $DIST < $1
