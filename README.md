Axel’s Tiling Window Manager Setup
==================================

History, Background and Reasoning
---------------------------------

While being a heavy [FVWM](http://www.fvwm.org/) user for nearly 15
years, I now run tiling window managers on all my “desktops” and
laptops, ranging from a first generation ASUS EeePC 701 4G netbook
over a Sun UltraSparc 10 to a full-fledged multihead workstation from
[Dalco](http://www.dalco.ch/) at work.

My ASUS EeePC 701 running [Debian GNU/Linux](http://www.debian.org/)
[Sid](http://www.debian.org/releases/sid/) was the first box where
I did not use FVWM anymore, because with a resolution of 800×480 on a
7 inch screen, you a) want to waste as few pixels as possible by title
bars, borders, … and b) most of the time anything else than fullscreen
windows doesn’t make sense, moving windows around with the mouse makes
even less sense.

So I’ve chosen [ratpoison](http://www.nongnu.org/ratpoison/) for the
EeePC (and still use it on that box) since it makes windows fullscreen
by default and the keybindings are nearly identical to
[GNU Screen](http://www.gnu.org/software/screen/) and therefore easy
to learn respectively I didn’t have to learn anything to use it.

After more and more fine tuning involving the
[xmobar](http://projects.haskell.org/xmobar/) text status bar, filled
with data by [i3status](http://i3wm.org/i3status/), I started this git
repository to track my own changes, to share the setup with some other
of my boxes (like the UltraSparc or my bed-side terminal, an older
ThinkPad A31).

Getting used with a fullscreen and tiling setup on the EeePC I more
and more wanted something for my everyday ThinkPad T61, too. But while
ratpoison is really perfect for the small EeePC screen, it proved too
clumsy for more complex window arrangements and multiple virtual
desktops.

So I looked through the other tiling window managers in Debian, trying
out [i3](http://i3wm.org/), scrotwm (nowadays called
[spectrwm](https://opensource.conformal.com/wiki/spectrwm)),
[wmii](http://wmii.suckless.org/), [awesome](http://awesome.naquadah.org/)
and some ion successors ([tritium](http://sf.net/projects/tritium/)
and [anion3](https://code.google.com/p/anion3/) the latter now being
superseeded by [notion](http://notion.sourceforge.net/)). I finally
stuck with awesome, first the 2.x version from Debian 5.0 Lenny, now
the 3.x version from Debian 6.0 Squeeze and later.

In general I liked the idea of using the — on Linux mostly unused —
Windows key as window manager meta key. I even configured my ratpoison
to use that in addition to the original `Ctrl-T` prefix.

You will also find some configuration for [i3](http://i3wm.org/)
(version 4 and upwards) in the repo as I also experiment with i3’s
tree-based layout to see if I can workaround some of awesome’s
shortcomings by using i3 instead.


Repository Name and URLs
------------------------

So this repository is no more a ratpoison-only setup. But since I
neither want to change the repository name nor any URL I decided that
I stick with having “ratpoison” in the name. The amount of “rodent”
usage you need with this setup hasn’t changed anyway, so without the
relation to the window manager of this name, the name is still fitting
(as it fits to the window manager of that name :-).


Installation
------------

These files are needed to get the setup running. The setup currently
runs on Debian Sid, Wheezy and Squeeze as well as Ubuntu Natty,
Oneiric and Precise. It probably also runs on older Ubuntu releases.

Since most of the configuration files included are not expected to
reside in `.ratpoison`, some symlinks are necessary where config file
paths cannot be set via command line options or where it would be to
tedious to always type them:

    ~/.gitconfig   → gitconfig
    ~/.xsession    → xsession
    ~/.screenrc    → screenrc
    ~/.colordiffrc → colordiffrc
    ~/.emacs       → emacs.el

These symbolic links can also be automatically set up by calling
`bin/setup-symlinks.sh` from this repository.

### Source Code

Sources available via
[my own Git server](http://git.noone.org/?p=ratpoison.git),
[Gitorious](http://gitorious.org/abe/ratpoison-desktop), and
[GitHub](http://github.com/xtaran/ratpoison-desktop).

Requirements
------------

### Required Software Packages

Needs at least the following Debian packages (besides essential
packages) to be installed:

* [busybox-syslogd](http://packages.debian.org/stable/busybox-syslogd)
  (for `logread`)
* [conkeror](http://packages.debian.org/stable/conkeror) or some other
  web browser
* [emacs](http://packages.debian.org/stable/emacs) (or any other
  emacsen, for `emacs` and `emacsclient`)
* [gnome-keyring](http://packages.debian.org/stable/gnome-keyring)
* [hsetroot](http://packages.debian.org/stable/hsetroot)
* [i3status](http://packages.debian.org/stable/i3status) ≥ 2.2
* [libfile-slurp-perl](http://packages.debian.org/stable/libfile-slurp-perl)
* [libfile-temp-perl](http://packages.debian.org/stable/libfile-temp-perl)
* [lsb-release](http://packages.debian.org/stable/lsb-release)
* [ratmenu](http://packages.debian.org/stable/ratmenu) ≥ 2.3.20
* [ratpoison](http://packages.debian.org/stable/ratpoison) or
  [awesome](http://packages.debian.org/stable/awesome) +
  [awesome-extra](http://packages.debian.org/stable/awesome-extras)
* [dnsutils](http://packages.debian.org/stable/dnsutils) |
  [wget](http://packages.debian.org/stable/wget) (needed by `iplet`)
* [x11-utils](http://packages.debian.org/stable/x11-utils) (for
  `xmessage`) | [gxmessage](http://packages.debian.org/stable/gxmessage)
* [x11-xserver-utils](http://packages.debian.org/stable/x11-xserver-utils)
  (for `xmodmap`, `xrdb`, `xrandr` and `xsetroot`)
* [xmobar](http://packages.debian.org/stable/xmobar)
* [xscreensaver](http://packages.debian.org/stable/xscreensaver) or
  [xtrlock](http://packages.debian.org/stable/xtrlock)
* [xterm](http://packages.debian.org/stable/xterm) and/or
  [rxvt-unicode](http://packages.debian.org/stable/rxvt-unicode)
* For Focus-Follows-Mouse:
  * for awesome: [xdotool](http://packages.debian.org/stable/xdotool)
  * for ratpoison: [xdotool](http://packages.debian.org/stable/xdotool) or
    [nawm](http://packages.qa.debian.org/nawm) (no more in Debian)

### Used Fonts

Fonts used for xmobar:

* [ttf-mplus](http://packages.debian.org/stable/ttf-mplus) |
  [fonts-mplus](http://packages.debian.org/testing/fonts-mplus)
* [ttf-droid](http://packages.debian.org/squeeze-backports/ttf-droid) |
  [fonts-droid](http://packages.debian.org/squeeze-backports/fonts-droid)
* [xfonts-terminus](http://packages.debian.org/stable/xfonts-terminus)

### Optional Software Packages

Used if available but except the system tray stuff recommended anyway:

* [autocutsel](http://packages.debian.org/stable/autocutsel)
* [emacs-goodies-el](http://packages.debian.org/stable/emacs-goodies-el)
  (for `markdown-mode` and others)
* [gnome-settings-daemon](http://packages.debian.org/stable/gnome-settings-daemon)
* [inotail](http://packages.debian.org/stable/inotail) (Linux only)
* [keynav](http://packages.debian.org/stable/keynav) ≥
  0.20101014.3067
* [redshift](http://packages.debian.org/stable/redshift)
* [unclutter](http://packages.debian.org/stable/unclutter)
* [x11-xkb-utils](http://packages.debian.org/stable/x11-xkb-utils)
  (for `setxkbmap`)
* [xrootconsole](http://packages.debian.org/stable/xrootconsole)
* [xserver-xorg-input-synaptics](http://packages.debian.org/stable/xserver-xorg-input-synaptics)
  (for `synclient`)
* [yeahconsole](http://packages.debian.org/stable/yeahconsole)
* System tray applets for use with awesome:
  * [nm-applet](http://packages.debian.org/stable/network-manager-gnome) |
    [wicd-gtk](http://packages.debian.org/stable/wicd-gtk)
  * [update-notifier](http://packages.debian.org/stable/update-notifier)
  * [gtk-redshift](http://packages.debian.org/stable/gtk-redshift)
  * [fdpowermon](http://packages.debian.org/testing/fdpowermon)
  * [radiotray](http://packages.debian.org/stable/radiotray)
  * [shutter](http://packages.debian.org/stable/shutter)
  * [yarssr](http://packages.debian.org/stable/yarssr)
  * [clipit](http://packages.debian.org/testing/clipit) |
    [parcellite](http://packages.debian.org/stable/parcellite)
  * [qasmixer](http://packages.debian.org/squeeze-backports/qasmixer) |
    [volumeicon-alsa](http://packages.debian.org/testing/volumeicon-alsa) |
    [volti](http://packages.debian.org/testing/volti)
  * [smart-notifier](http://packages.debian.org/stable/smart-notifier)
  * [amorad-gui](http://packages.debian.org/stable/amora-applet)
* For use with ratpoison only so far:
  * [notification-daemon](http://packages.debian.org/stable/notification-daemon) |
    [dunst](http://packages.debian.org/testing/dunst)

### Kernel Modules

Linux kernel modules which may be used by some features of xmobar, but
do not seem to be loaded automatically (write them into `/etc/modules`):

* `acpi_cpufreq`
* `coretemp`

### Software Packages used by Scripts or Keybindings

Only used in non-necessary scripts or keybindings:

* [dwm-tools](http://packages.debian.org/stable/dwm-tools) ≥ 31-1 or
  [suckless-tools](http://packages.debian.org/stable/suckless-tools)
  (for `dmenu`, `tabbed` and `wmname`)
* [openssh-client](http://packages.debian.org/stable/openssh-client)
  (for `ssh-add` and `ssh-agent`)
* [screen](http://packages.debian.org/stable/screen) or
  [tmux](http://packages.debian.org/stable/tmux)
* [scrot](http://packages.debian.org/stable/scrot)
* [xclip](http://packages.debian.org/stable/xclip)
* [colordiff](http://packages.debian.org/stable/colordiff)
* [git](http://packages.debian.org/stable/git)

### Software Packages used in Commented Code

Only in commented code (i.e. currently not used):

* Alternative window and session managers:
  * [i3](http://packages.debian.org/stable/i3-wm)
  * [flwm](http://packages.debian.org/stable/flwm)
  * [fvwm](http://packages.debian.org/stable/fvwm)
  * [lxsession](http://packages.debian.org/stable/lxsession)
  * [spectrwm](http://packages.debian.org/testing/spectrewm) (formerly
    [scrotwm](http://packages.debian.org/stable/scrotwm))
  * [stumpwm](http://packages.debian.org/stable/stumpwm)
  * [tritium](http://packages.debian.org/stable/tritium)
  * [notion](http://packages.debian.org/testing/notion)
* [loco](http://packages.qa.debian.org/loco) (no more in Debian) |
  [ccze](http://packages.debian.org/stable/ccze) |
  [lwatch](http://packages.debian.org/stable/lwatch) |
  [colortail](http://packages.debian.org/stable/colortail)
* [root-tail](http://packages.debian.org/stable/root-tail)

Debian Metapackages
-------------------

The project’s subdirectory `abe-desktop` resembles a Debian source
package which generates several `.deb` metapackages.

### Metapackages for my Desktop Setup

The following metapackages provide all the dependencies mentioned
above:

* abe-desktop-ratpoison: Contains dependencies for the ratpoison-based
  desktop
* abe-desktop-awesome: Contains dependencies for the awesome-based
  desktop
* abe-desktop-common: Contains dependencies common to both, the
  ratpoison-based and the awesome-based desktop.
* abe-desktop: Contains dependencies on all of the above plus
  additional window managers mentioned below.

### Other Metapackages

For pure maintenance convenience, additional metapackages are part of
this repository. They contain dependencies on further packages I
commonly want installed on my boxes, too:

* abe-commandline: Commandline tools I usually use. Its hard
  dependencies are also suitable for servers.
* abe-emacs: Emacs modes and other Emacs add-ons I usually want on all
  boxes where I install GNU Emacs anyway.
* abe-gnome: GUI tools and applications I usually install if some
  GNOME dependencies are ok.
* abe-office: Depends on the LibreOffice/GnomeOffice applications I
  prefer.
* abe-laptop: Packages I commonly need on laptops and netbooks. ACPI
  stuff, resource saving and monitoring stuff, … Also satisfies some
  of ubuntu-minimal’s hard dependencies to be able to e.g. install a
  different syslog daemon without removing the metapackage.

### APT Repository

All those metapackages are usually also available from
[my APT repository](http://noone.org/apt/).
