#!/bin/sh

# Define some variables used within this script
export RP=$(dirname "$(readlink "$0")")

. $RP/common/init.sh

# Keyboard and X configuration
if [ -r $PH/xmodmap.$HOSTNAME ]; then
    xmodmap $PH/xmodmap.$HOSTNAME
fi
if [ -r $PH/Xresources.$HOSTNAME ]; then
    xrdb -merge $PH/Xresources.$HOSTNAME
fi
xrdb -merge $RP/Xresources

# Allow Ctrl-Alt-Backspace to kill the X server and remove CAPS-LOCK
whe setxkbmap -option terminate:ctrl_alt_bksp -option ctrl:nocaps

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
whe syndaemon -i 1 -d

# Some GNOME stuff I need (use either xscreensaver or
# gnome-settings-daemon, but not both at the same time, because
# gnome-settings-daemon starts xscreensaver, too.)
eval `gnome-keyring-daemon -s`
whee xscreensaver -no-splash

# Unlock SSH Keys -- now done ondemand with GNOME Keyring
#ssh-add

# Set hostname based environment variables for devscripts, namely
# $DEBEMAIL and the default package signing key.
if [ -r "$HOME/.zsh/zsh.d/60-debian" ]; then
    . "$HOME/.zsh/zsh.d/60-debian"
fi

# Start some GNOME foo if installed
whee gnome-settings-daemon
whee gnome-power-manager

# Yeahconsole with Ctrl-Alt-Z, needs to come after the gnome keyring
# daemon.
whee yeahconsole

#(logread; logread -f) | root-tail --color white --update --cont + --cont-color blue --justify --outline --noflicker --interval 1 -fn "$FONT" -g '798x454+2+0' -,darkorange,'System Log' ${HOME}/.xsession-errors,white,'X session errors' &
if wh xrootconsole; then
    ( if wh logread; then
        logread | tail -100;
	logread -f
      else
        tail -F /var/log/syslog
      fi &
      if wh inotail; then
	  inotail -f $HOME/.xsession-errors
      else
	  tail -f $HOME/.xsession-errors
      fi ) | \
#     ( loco || \
#       ccze -A -o noscroll || \
#       colortail -k $RP/colortail.conf -q -f /dev/stdin || \
#       lwatch -i- ) | \
    xrootconsole -fg white -fn "$FONT" -geometry "${WT}x${HT}+2+1" &
fi

# Trayer needs to be started after ratpoison
( sleep 1; \
  #xterm &
  urxvt &
  start_bar &
  #sleep 1;
  whee unclutter -keystroke -idle 2
  whe synclient TapButton1=1 HorizTwoFingerScroll=1 VertTwoFingerScroll=1
  #sleep 10;
  #conkeror &
  #sleep 3
  #emacs &
) &

#if wh xcompmgr && [ "`hostname`" != 'metisse' ]; then
#    xcompmgr -O .01 -D 5 -f -r 1 -o .6 -C -F -l 0 -t 0 -o 0 &
#fi

if [ -x $PH/xsession.$HOSTNAME ]; then
    . $PH/xsession.$HOSTNAME
fi

# If resolution is less than 1024 pixels wide, then use ratpoison, else awesome
if [ `xwininfo -root -stats | awk '/Width:/ {print $2}'` -lt 1024 ]; then
    # Call nawm for focus follows mouse with ratpoison
    if [ -x $RP/sloppy/sloppy ]; then
	$RP/sloppy/sloppy &
    elif [ -x /usr/bin/sloppy ]; then
	/usr/bin/sloppy &
    else
	whee nawm -f $RP/nawmrc
    fi

    # Use redshift if installed
    whee redshift -l $LOC

    exec ratpoison -f $RP/ratpoisonrc
else
    whe wmname awesome
    whee nm-applet
    whee wicd-gtk -t
    whee update-notifier
    whee fdpowermon
    whee radiotray
    whee volumeicon
    whee yarssr
    whee shutter --min_at_startup
    # Use redshift if installed
    whe gtk-redshift -l $LOC || whe redshift -l $LOC &
    exec awesome -c $RP/awesome/rc.lua
fi

#exec lxsession -session ratpoison
#exec stumpwm
#exec flwm -g 800x454+0+0 -fg orange -bg black -cfg orange -bfg black
#exec fvwm
#exec i3
#exec scrotwm
#exec tritium
