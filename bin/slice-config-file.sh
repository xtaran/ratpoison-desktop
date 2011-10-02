#!/bin/sh

HOSTNAME=`( test -z "$2" && uname -n || echo $2 ) | tr a-z A-Z`
DIST=`( test -z "$3" && lsb_release -cs || echo $3 ) | tr a-z A-Z`

slice -o "UNDEF+$HOSTNAME+$DIST-NOT$DIST-NOT$HOSTNAME:-" $1
