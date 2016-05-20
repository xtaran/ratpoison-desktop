#!/bin/sh

# Define some variables used within this script
export RP=$(dirname "$(readlink "$0")")

. $RP/common/init.sh

# Allow Ctrl-Alt-Backspace to kill the X server and remove CAPS-LOCK
whe setxkbmap -option terminate:ctrl_alt_bksp -option ctrl:nocaps

# Keyboard and X configuration
if [ -r $PH/xmodmap.$HOSTNAME ]; then
    xmodmap $PH/xmodmap.$HOSTNAME
fi
if [ -r $PH/Xresources.$HOSTNAME ]; then
    xrdb -merge $PH/Xresources.$HOSTNAME
fi
xrdb -merge $RP/Xresources

# Audio settings
#xset b 100 1200 240

# Background
set_background

# Daemons (ssh-agent started from session management)
if [ -n "$GPG_AGENT_INFO" ]; then
    eval `gpg-agent --daemon`
fi

# Needs ssh around it.
#synergyc snitch

# Tools for a better X experience
whee keynav "loadconfig $RP/keynavrc"
whee autocutsel
#whe syndaemon -i 1 -d

# Some GNOME stuff I need (use either xscreensaver or
# gnome-settings-daemon, but not both at the same time, because
# gnome-settings-daemon starts xscreensaver, too.)
eval `gnome-keyring-daemon -s -c pkcs11,secrets`
whee xscreensaver -no-splash

# Not really a systray applet, just yet another daemon needed for
# printing at ETH.
whee system-config-printer-applet

# Unlock SSH Keys -- now done ondemand with GNOME Keyring
#ssh-add

# Set hostname based environment variables for devscripts, namely
# $DEBEMAIL and the default package signing key.
if [ -r "$HOME/.zsh/zsh.d/60-debian" ]; then
    . "$HOME/.zsh/zsh.d/60-debian"
fi

# Start some GNOME foo if installed, should be maybe replaced by XFCE foo.
whe xsettingsd || whe cinnamon-settings-daemon || whe gnome-settings-daemon || whe mate-settings-daemon &
#whee gnome-power-manager

# Yeahconsole with Ctrl-Alt-Z, needs to come after the gnome keyring
# daemon.
whee yeahconsole

# Trayer needs to be started after ratpoison
( sleep 1; \
  #xterm &
  #urxvt &
  #sleep 1;
  #whee unclutter -keystroke -idle 2
  whe synclient TapButton1=1 HorizTwoFingerScroll=1 VertTwoFingerScroll=1
  #sleep 10;
  #conkeror &
  #sleep 3
  #emacs &
  whee udev-notify
) &

# If resolution is less than 1024 pixels wide, then use ratpoison, else awesome
if [ `xwininfo -root -stats | awk '/Width:/ {print $2}'` -lt 1024 -o "$HOSTNAME" = "jumper" ]; then
    # Try several variants to get focus follows mouse with ratpoison
    # 1. system sloppy command
    if [ -x /usr/bin/sloppy ]; then
	( sleep 2 ; env RATPOISON=`which ratpoison` /usr/bin/sloppy ) &
    # 2. local sloppy command until http://bugs.debian.org/649523 is fixed
    elif [ -x $RP/sloppy/sloppy ]; then
	( sleep 2 ; env RATPOISON=`which ratpoison` $RP/sloppy/sloppy ) &
    # 3. use nawm (if available) else
    else
	whee nawm -f $RP/nawmrc
    fi

    # Use redshift and notification-daemon if installed
    whee redshift -l $LOC
    whe /usr/lib/notification-daemon/notification-daemon || whe dunst -fn "$FONT" -nb black -nf orange  -lb black -lf darkorange -cb orange -cf black &

    ( sleep 1; start_bar & ) &

    xsession_per_host

    if wh ratpoison; then
        exec ratpoison -f $RP/ratpoisonrc
    elif wh flwm; then
         exec flwm -g 800x454+0+0 -fg orange -bg black -cfg orange -bfg black
    fi
else
    if wh i3; then
        $RP/bin/slice-config-file.sh $RP/i3statusrc.slice I3BAR > $RP/i3statusrc
        xsession_per_host systray_applets i3bar
        exec i3 -c $RP/i3/config
    elif wh awesome; then
        whe wmname awesome
        xsession_per_host systray_applets
        start_bar &
        exec awesome -c $RP/awesome/rc.lua
    fi
fi

# Fallback
if wh x-window-manager; then
    exec x-window-manager
elif wh x-session-manager; then
    exec x-session-manager
else
    exec xmessage No X window manager found
fi

#exec lxsession -session ratpoison
#exec stumpwm
#exec flwm -g 800x454+0+0 -fg orange -bg black -cfg orange -bfg black
#exec fvwm
#exec i3
#exec scrotwm
#exec spectrwm
#exec tritium
#exec notion
