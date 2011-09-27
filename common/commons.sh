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
LOC='47.399453:8.507232'

# Path
export PATH="${PATH}:/sbin:/usr/sbin:${RP}/bin"

# Locales
export LANG=en_US.UTF-8

# Define some functions
wh() {
    which "$1" > /dev/null
}
whe() {
    wh "$1" && "$@"
}
whee() {
    wh "$1" && exec "$@" &
}

# Define some environment variables used by programs called by this script
if wh iwconfig; then
    WLAN_IF="wireless "`iwconfig 2>&1 | fgrep 'IEEE 802.11' | awk '{print $1}' | head -1`
    export WLAN_IF
fi

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
	i3status -c $RP/i3statusrc
    fi | if [ -r $PH/xmobarrc.$HOSTNAME ]; then
	env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $PH/xmobarrc.$HOSTNAME
    else
	env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $RP/xmobarrc
    fi
}