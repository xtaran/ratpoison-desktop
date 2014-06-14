# -*- shell-script -*-
# Define some common variables used within my desktop scripts
PH=$RP/per-host
BG=$HOME/.backgrounds
W=`xwininfo -root | fgrep Width: | awk '{print $2}'`
H=`xwininfo -root | fgrep Height: | awk '{print $2}'`
WT=`expr $W / 6`
HT=`expr $H / 11 - 1`
HOSTNAME=`uname -n`
# Alternative font: -misc-fixed-medium-r-*-*-12-*-*-*-*-60-iso10646-1
FONT='-xos4-terminus-medium-r-normal-*-12-120-72-72-c-60-iso10646-1'
# Redshift parameters
LOC='47.399453:8.507232'
RSTEMP='5500K:4500K'

# Path
export PATH="${PATH}:/sbin:/usr/sbin:${HOME}/${RP}/bin"

# Locales -- I prefer C.UTF-8, but that's just available on
# debian-based distros since 2011, so lets first check which of my
# preferred locales are actually available.
for locale in C.UTF-8 en_US.UTF-8 en_US.utf8; do
    if locale -a | fgrep -q $locale ; then
        export LANG=$locale
        break
    fi
done

. $RP/common/commons.sh

set_background() {
    xsetroot -solid black
    #hsetroot -tile $BG/mathe_wall.png
    #hsetroot -full $BG/emu.800x480.jpg
    imageprefix=$BG/$HOSTNAME
    for imagesuffix in full fill tile; do
	if [ -r "$imageprefix.$imagesuffix" ]; then
	    hsetroot -$imagesuffix "$imageprefix.$imagesuffix"
	fi
    done
}

start_bar() {
    if [ -r $PH/i3statusrc.$HOSTNAME ]; then
	i3status -c $PH/i3statusrc.$HOSTNAME
    else
	$RP/bin/slice-config-file.sh $RP/i3statusrc.slice > $RP/i3statusrc
	i3status -c $RP/i3statusrc
    fi | if [ -r $PH/xmobarrc.$HOSTNAME ]; then
	env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $PH/xmobarrc.$HOSTNAME
    else
	$RP/bin/slice-config-file.sh $RP/xmobarrc.slice > $RP/xmobarrc
	env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $RP/xmobarrc
    fi
}
