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
    whe qasmixer -t || whe volumeicon &
    whee yarssr
    whee shutter --min_at_startup
    # Use redshift if installed
    whe gtk-redshift -l $LOC || whe redshift -l $LOC &
}
