#!/bin/sh

# Define some variables used within this script
export RP=$(dirname "$(readlink "$0")")
BG=$HOME/.backgrounds
W=`xwininfo -root | fgrep Width: | awk '{print $2}'`
H=`xwininfo -root | fgrep Height: | awk '{print $2}'`
WT=`expr $W / 6`
HT=`expr $H / 11 - 1`
FONT='-xos4-terminus-medium-r-normal-*-12-120-72-72-c-60-iso10646-1'
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

# Keyboard and X configuration
if [ -r $RP/xmodmap-`uname -n` ]; then
    xmodmap $RP/xmodmap-`uname -n`
fi
if [ -r $RP/Xresources-`uname -n` ]; then
    xrdb -merge $RP/Xresources-`uname -n`
fi
xrdb -merge $RP/Xresources

# Allow Ctrl-Alt-Backspace to kill the X server and remove CAPS-LOCK
whe setxkbmap -option terminate:ctrl_alt_bksp -option ctrl:nocaps

# Use redshift if installed
whe gtk-redshift -l 47.399453:8.507232 || whe redshift -l 47.399453:8.507232 &

# Audio settings
#xset b 100 1200 240

# Background
xsetroot -solid black
#hsetroot -tile $BG/mathe_wall.png
#hsetroot -full $BG/emu.800x480.jpg
imageprefix=$BG/`uname -n`
for imagesuffix in full fill tile; do
    if [ -r "$imageprefix.$imagesuffix" ]; then
	hsetroot -$imagesuffix "$imageprefix.$imagesuffix"
    fi
done

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
#    ( loco || \
#      ccze -A -o noscroll || \
#      colortail -k $RP/colortail.conf -q -f /dev/stdin || \
#      lwatch -i- ) | \
    whee xrootconsole -fg white -fn "$FONT" -geometry "${WT}x${HT}+2+1"

# Trayer needs to be started after ratpoison
( sleep 1; \
  #xterm &
  urxvt &
  # Alternative font: -misc-fixed-medium-r-*-*-12-*-*-*-*-60-iso10646-1
  #i3status -c .i3statusrc | dzen2 -p 3 -fg white -bg black -fn "$FONT" -m -y 440 &
  if [ -r $RP/i3statusrc.`uname -n` ]; then
      i3status -c $RP/i3statusrc.`uname -n`
  else
      i3status -c $RP/i3statusrc
  fi | env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $RP/xmobarrc &
  #sleep 1;
  whee unclutter -keystroke -idle 2 -grab
  #sleep 10;
  #conkeror &
  #sleep 3
  #emacs &
) &

#if wh xcompmgr && [ "`hostname`" != 'metisse' ]; then
#    xcompmgr -O .01 -D 5 -f -r 1 -o .6 -C -F -l 0 -t 0 -o 0 &
#fi

if [ -x $RP/xsession.`uname -n` ]; then
    . $RP/xsession.`uname -n`
fi

# If resolution is less than 1024 pixels wide, then use ratpoison, else awesome
if [ `xwininfo -root -stats | awk '/Width:/ {print $2}'` -lt 1024 ]; then
    # Call nawm for focus follows mouse with ratpoison
#    if wh xdotool; then
#	while :; do xdotool search . behave %@ mouse-enter windowfocus > /dev/null 2>&1; done &
#    else
	whee nawm -f $RP/nawmrc
#    fi
    exec ratpoison -f $RP/ratpoisonrc
else
    whe wmname awesome
    whee nm-applet
    whee wicd-gitk
    whee update-notifier
    exec awesome -c $RP/awesome/rc.lua
fi

#exec lxsession -session ratpoison
#exec stumpwm
#exec flwm -g 800x454+0+0 -fg orange -bg black -cfg orange -bfg black
#exec fvwm
#exec i3
#exec scrotwm
#exec tritium
