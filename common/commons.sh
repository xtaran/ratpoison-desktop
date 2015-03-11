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
    whee connman-ui-gtk
    whee update-notifier
    whee smart-notifier
    whee fdpowermon
    whee amora-applet
    whee nagstamon
    whee specto
    whee dnssec-trigger-panel
    whe xfce4-volumed
    whe qasmixer -t || whe volumeicon || whe volti &
    # Use redshift if installed
    whe gtk-redshift -l $LOC -t $RSTEMP || whe redshift-gtk -l $LOC -t $RSTEMP || whe redshift -l $LOC -t $RSTEMP &
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
