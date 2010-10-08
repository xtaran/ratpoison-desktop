#!/bin/sh

RP=$(dirname "$(readlink "$0")")
BG=$HOME/.backgrounds

# Keyboard and X configuration
if [ -r $RP/xmodmap-`uname -n` ]; then
    xmodmap $RP/xmodmap-`uname -n`
fi
xrdb -merge $RP/Xresources

# Background
xsetroot -solid black
#hsetroot -tile $BG/mathe_wall.png
#hsetroot -full $BG/emu.800x480.jpg
hsetroot -full $BG/hintergrundbild_04_16-10.800x480-crop.png

# Daemons (ssh-agent started from session management)
eval `gpg-agent --daemon`

# Tools for a better X experience
keynav &
autocutsel &
syndaemon -i 1 -d

# Some GNOME stuff I need (use either xscreensaver or
# gnome-settings-daemon, but not both at the same time, because
# gnome-settings-daemon starts xscreensaver, too.)
eval `gnome-keyring-daemon -s`
xscreensaver -no-splash &
#gnome-settings-daemon
#/usr/lib/gnome-volume-manager/gnome-volume-manager &

# Unlock SSH Keys -- now done ondemand with GNOME Keyring
#ssh-add

if [ -r "$HOME/.zsh/zsh.d/60-debian" ]; then
    . "$HOME/.zsh/zsh.d/60-debian"
fi

# Yeahconsole with Ctrl-Alt-Z, needs to come after the gnome keyring
# daemon.
yeahconsole &

#(logread; logread -f) | root-tail --color white --update --cont + --cont-color blue --justify --outline --noflicker --interval 1 -fn '-xos4-terminus-*-r-*-*-12-120-*-*-*-60-iso10646-1' -g '798x454+2+0' -,darkorange,'System Log' ${HOME}/.xsession-errors,white,'X session errors' &
(logread; logread -f & inotail -f .xsession-errors) | xrootconsole -fg white -fn '-xos4-terminus-*-*-*-*-12-120-*-*-*-60-iso10646-1' -geometry '133x39+2+2' &

# Trayer needs to be started after ratpoison
( sleep 1; \
#  trayer --align right --edge bottom --distance 0 --expand true \
#         --transparent true --alpha 128 --tint 0 \
#         --SetDockType true --SetPartialStrut true &
## --heighttype percent --height 100 --widthtype request
  #lxpanel &
  #xterm &
  urxvt &
  # Alternative font: -misc-fixed-medium-r-*-*-12-*-*-*-*-60-iso10646-1
  #i3status -c .i3statusrc | dzen2 -p 3 -fg white -bg black -fn '-xos4-terminus-*-*-*-*-12-120-*-*-*-60-iso10646-1' -m -y 440 &
  #i3status-xmobar -c ~/.i3statusrc | env PATH="/home/abe/bin:$PATH" xmobar ~/.xmobarrc &
  i3status -c $RP/i3statusrc | env PATH="$RP/bin:/home/abe/bin:$PATH" xmobar $RP/xmobarrc &
  #sleep 1;
  #nm-applet &
  #parcellite &
  unclutter &
  #sleep 10;
  #wicd-client &
  #osd_clock -c orange -o 6 -f fixed -F '%A, %e. %B %Y, %T' &
  #conkeror &
  #sleep 3
  #emacs &
) &

#while :; do
#  uptime | sed -e 's/load average: //;s/^.*up //;' | \
#    osd_cat -c orange -p bottom -A center -f fixed -o -44 -d 5.1 - &
#  sleep 5;
#done &

xcompmgr -O .01 -D 5 -f -r 1 -o .6 -C -F -l 0 -t 0 -o 0 &

#exec lxsession -session ratpoison
exec ratpoison
#exec stumpwm
#exec flwm -g 800x454+0+0 -fg orange -bg black -cfg orange -bfg black
#exec fvwm
