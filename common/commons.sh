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
waitfor() {
    until ps x | fgrep -v grep | fgrep -q "$1"; do
        sleep 1;
    done
}

systray_applets() {
    if [ -n "$1" ]; then
        waitfor "$1"
    fi
    whee systray-mdstat
    whee nm-applet
    whee wicd-gtk -t
    whee dhcpcd-gtk
    whee connman-ui-gtk
    whee update-notifier
    whee smart-notifier
    whee fdpowermon
    whee amora-applet
    whee nagstamon
    whee specto
    whee dnssec-trigger-panel
    whee solaar
    whee usbguard-applet-qt
    whee ss-qt5
    whee kernelopps-applet
    whe xfce4-volumed
    whe qasmixer -t || whe volumeicon || whe volti &
    # Use redshift if installed
    whe gtk-redshift -l "$LOC" -t "$RSTEMP" || whe redshift-gtk -l "$LOC" -t "$RSTEMP" || whe redshift -l "$LOC" -t "$RSTEMP" &
}

xsession_per_host() {
    if [ -e "$PH/xsession.$HOSTNAME" ]; then
	sleep 1
	. "$PH/xsession.$HOSTNAME"
    elif [ -n "$*" ]; then
        uxterm &
	"$@"
    fi &
}
