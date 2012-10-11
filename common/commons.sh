# -*- shell-script -*-
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

systray_applets() {
    whe wmname awesome
    whee nm-applet
    whee wicd-gtk -t
    whee update-notifier
    whee smart-notifier
    whee fdpowermon
    whee radiotray
    whee amora-applet
    whe clipit || whe parcellite &
    whe qasmixer -t || whe volumeicon || whe volti &
    [ -n "`find $HOME/.yarssr/state -type f`" ] && whee yarssr
    whee shutter --min_at_startup
    # Use redshift if installed
    whe gtk-redshift -l $LOC || whe redshift -l $LOC &
}

xsession_per_host() {
    if [ -e $PH/xsession.$HOSTNAME ]; then
	sleep 1
	. $PH/xsession.$HOSTNAME
    elif [ -n "$*" ]; then
        uxterm &
	"$@"
    fi &
}
