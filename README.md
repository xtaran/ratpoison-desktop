Axel’s Tiling Window Manager Setup
==================================

History, Background and Reasoning
---------------------------------

### The Early Days: FVWM

While having been a heavy [FVWM](https://www.fvwm.org/) user for nearly
15 years, I now run tiling window managers on all my “desktops” and
laptops, ranging from a first generation 7" ASUS EeePC 701 4G netbook
(unfortunately died in early 2014, has been replaced by a 9" ASUS
EeePC 900A) and Raspberry Pis over a Sun UltraSparc 10 to a
full-fledged multihead workstation from [Tuxedo
Computers](https://www.tuxedocomputers.com/) at home (and a similar
one from a different brand at work) and several generations of
Thinkpads ranging from a 760XD over an A31 and T61 to an X250.

### Tasting Blood with Ratpoison

My ASUS EeePC 701 running [Debian GNU/Linux](https://www.debian.org/)
[Sid](https://www.debian.org/releases/sid/) was the first box where
I did not use FVWM anymore, because with a resolution of 800×480 on a
7 inch screen, you a) want to waste as few pixels as possible by title
bars, borders, … and b) most of the time anything else than fullscreen
windows doesn’t make sense, moving windows around with the mouse makes
even less sense.

So I’ve chosen [ratpoison](https://www.nongnu.org/ratpoison/) for the
EeePC (and would still use it on that box) since it makes windows
fullscreen by default and the keybindings are nearly identical to
[GNU Screen](https://www.gnu.org/software/screen/) and therefore easy
to learn respectively I didn’t have to learn anything to use it.

After more and more fine tuning involving the
[xmobar](https://xmobar.org/) text status bar, filled
with data by [i3status](https://i3wm.org/i3status/), I started this git
repository to track my own changes, to share the setup with some other
of my boxes (like the UltraSparc or my bed-side terminal, an older
ThinkPad A31).

### Advancing to Awesome

Getting used with a fullscreen and tiling setup on the EeePC I more
and more wanted something for my everyday ThinkPad back then (a T61),
too. But while ratpoison is really perfect for the small EeePC screen,
it proved too clumsy for more complex window arrangements and multiple
virtual desktops.

So I looked through the other tiling window managers in Debian, trying
out [i3](https://i3wm.org/) (3.x versions), scrotwm (nowadays called
[spectrwm](https://opensource.conformal.com/wiki/spectrwm)),
[wmii](https://web.archive.org/web/20121016035433/http://wmii.suckless.org/),
[awesome](https://awesomewm.org/) and some ion successors
([tritium](https://sf.net/projects/tritium/) and
[anion3](https://web.archive.org/web/20201026010954if_/https://code.google.com/archive/p/anion3/)
the latter now being superseeded by
[notion](https://www.notionwm.net/)). I eventually stuck with awesome,
first the 2.x version from Debian 5.0 Lenny, then the 3.x version from
Debian 6.0 Squeeze and later.

In general I liked the idea of using the—on Linux mostly
unused—Windows key as window manager meta key. I even configured
ratpoison to use that in addition to the original `Ctrl-T` prefix.

### Dropping Awesome in Favour of i3

A few years later I got annoyed by awesome (≥ 3.5) and the
[awesome-extra widget libraries package](https://packages.debian.org/stable/awesome-extras)
diverging (by the latter not being updated to awesome 3.5 and hence
becoming unusable unless you put the awesome package on hold with a
3.4.x version), so I looked again at [i3](https://i3wm.org/) (now the
4.x versions) and eventually started migrating to it.

Nowadays I mostly only use i3, except for some Raspberry Pis with tiny
screen resolutions. I haven't used awesome for quite some years now
and the awesome setup files in here likely no more work properly.


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
runs on Debian Sid, Debian 8 Jessie and Debian 7 Wheezy as well as
Ubuntu 14.04 Trusty, and 16.04 Xenial. It probably also still runs on
older releases.

Since most of the configuration files included are not expected to
reside in `.ratpoison`, some symlinks are necessary where config file
paths cannot be set via command line options or where it would be to
tedious to always type them:

    ~/.gitconfig   → gitconfig
    ~/.gitignore   → gitignore
    ~/.xsession    → xsession
    ~/.screenrc    → screenrc
    ~/.colordiffrc → colordiffrc
    ~/.lintianrc   → lintianrc
    ~/.emacs       → emacs.el

These symbolic links can also be automatically set up by calling
`bin/setup-symlinks.sh` from this repository.

### Source Code

Sources available
[on my own Git server](https://git.noone.org/?p=ratpoison.git),
[on GitHub](https://github.com/xtaran/ratpoison-desktop), and
[on GitLab](https://gitlab.com/xtaran/ratpoison-desktop). (An ancient,
read-only and no more updated version could also be found
[on Gitorious](https://gitorious.org/abe/ratpoison-desktop).)

Requirements
------------

### Required Software Packages

Needs at least the following Debian packages (besides essential
packages) to be installed:

* [conkeror](https://packages.debian.org/stable/conkeror) or some other
  web browser
* [emacs](https://packages.debian.org/stable/emacs) (or any other
  emacsen, for `emacs` and `emacsclient`)
* [gnome-keyring](https://packages.debian.org/stable/gnome-keyring)
* [hsetroot](https://packages.debian.org/stable/hsetroot)
* [i3status](https://packages.debian.org/stable/i3status) ≥ 2.2
* [libfile-slurp-perl](https://packages.debian.org/stable/libfile-slurp-perl)
* [libfile-temp-perl](https://packages.debian.org/stable/libfile-temp-perl)
* [lsb-release](https://packages.debian.org/stable/lsb-release)
* [ratmenu](https://packages.debian.org/stable/ratmenu) ≥ 2.3.20
* [ratpoison](https://packages.debian.org/stable/ratpoison) or
  [awesome](https://packages.debian.org/stable/awesome) < 3.5 +
  [awesome-extra](https://packages.debian.org/stable/awesome-extras)
* [dnsutils](https://packages.debian.org/stable/dnsutils) |
  [wget](https://packages.debian.org/stable/wget) (needed by `iplet`)
* [x11-utils](https://packages.debian.org/stable/x11-utils) (for
  `xmessage`) | [gxmessage](https://packages.debian.org/stable/gxmessage)
* [x11-xserver-utils](https://packages.debian.org/stable/x11-xserver-utils)
  (for `xmodmap`, `xrdb`, `xrandr` and `xsetroot`)
* [xmobar](https://packages.debian.org/stable/xmobar)
* [xscreensaver](https://packages.debian.org/stable/xscreensaver) or
  [xtrlock](https://packages.debian.org/stable/xtrlock)
* [xterm](https://packages.debian.org/stable/xterm) and/or
  [rxvt-unicode](https://packages.debian.org/stable/rxvt-unicode)
* For Focus-Follows-Mouse:
  * for awesome: [xdotool](https://packages.debian.org/stable/xdotool)
  * for ratpoison: [xdotool](https://packages.debian.org/stable/xdotool) or
    [nawm](https://packages.qa.debian.org/nawm) (no more in Debian)

### Used Fonts

Fonts used for xmobar:

* [ttf-mplus](https://packages.debian.org/stable/ttf-mplus) |
  [fonts-mplus](https://packages.debian.org/testing/fonts-mplus)
* [ttf-droid](https://packages.debian.org/squeeze-backports/ttf-droid) |
  [fonts-droid](https://packages.debian.org/squeeze-backports/fonts-droid)
* [xfonts-terminus](https://packages.debian.org/stable/xfonts-terminus)

### Optional Software Packages

Used if available but except the system tray stuff recommended anyway:

* [autocutsel](https://packages.debian.org/stable/autocutsel)
* [emacs-goodies-el](https://packages.debian.org/stable/emacs-goodies-el)
  (for `markdown-mode` and others)
* [inotail](https://packages.debian.org/stable/inotail) (Linux only)
* [keynav](https://packages.debian.org/stable/keynav) ≥
  0.20101014.3067
* [magit](https://packages.debian.org/stable/magit) (used in `emacs.el`)
* [redshift](https://packages.debian.org/stable/redshift)
* [udev-notify](https://launchpad.net/udev-notify) ([RFP](https://bugs.debian.org/670467))
* [unclutter](https://packages.debian.org/stable/unclutter)
* [x11-xkb-utils](https://packages.debian.org/stable/x11-xkb-utils)
  (for `setxkbmap`)
* [xserver-xorg-input-synaptics](https://packages.debian.org/stable/xserver-xorg-input-synaptics)
  (for `synclient`)
* [xsettingsd](https://github.com/derat/xsettingsd) (with fallback to
  other common settings-daemons)
* [yeahconsole](https://packages.debian.org/stable/yeahconsole)
* System tray applets for use with awesome or i3:
  * [wicd-gtk](https://packages.debian.org/stable/wicd-gtk) |
    [connman-ui](https://packages.debian.org/testing/connman-ui) |
    [nm-applet](https://packages.debian.org/stable/network-manager-gnome)
  * [update-notifier](https://packages.debian.org/stable/update-notifier)
  * [gtk-redshift](https://packages.debian.org/stable/gtk-redshift)
  * [fdpowermon](https://packages.debian.org/testing/fdpowermon)
  * [qasmixer](https://packages.debian.org/squeeze-backports/qasmixer) |
    [volumeicon-alsa](https://packages.debian.org/testing/volumeicon-alsa) |
    [volti](https://packages.debian.org/testing/volti)
  * [smart-notifier](https://packages.debian.org/stable/smart-notifier)
  * [amorad-gui](https://packages.debian.org/stable/amora-applet)
  * [nagstamon](https://packages.debian.org/stable/nagstamon)
  * [dnssec-trigger](https://packages.debian.org/testing/dnssec-trigger)
    (pulls in [unbound](https://packages.debian.org/testing/unbound))
  * [telegram-desktop](https://packages.debian.org/stable/telegram-desktop)
  * [systray-mdstat](https://packages.debian.org/stable/systray-mdstat)
  * [solaar](https://pwr.github.io/Solaar/)
  * [shadowsocks-qt5](https://github.com/shadowsocks/shadowsocks-qt5)
* For use with ratpoison only so far:
  * [notification-daemon](https://packages.debian.org/stable/notification-daemon) |
    [dunst](https://packages.debian.org/testing/dunst)

Unfortunately necessary for using ETH's new printing system:

* `system-config-printer-applet` from the package
  [system-config-printer](https://packages.debian.org/stable/system-config-printer)

### Kernel Modules

Linux kernel modules which may be used by some features of xmobar, but
do not seem to be loaded automatically (write them into `/etc/modules`):

* `acpi_cpufreq`
* `coretemp`

### Software Packages used by Scripts or Keybindings

Only used in non-necessary scripts or keybindings:

* [busybox-syslogd](https://packages.debian.org/stable/busybox-syslogd)
  (for `logread`)
* [dwm-tools](https://packages.debian.org/stable/dwm-tools) ≥ 31-1 or
  [suckless-tools](https://packages.debian.org/stable/suckless-tools)
  (for `dmenu`, `tabbed` and `wmname`)
* [openssh-client](https://packages.debian.org/stable/openssh-client)
  (for `ssh-add` and `ssh-agent`)
* [screen](https://packages.debian.org/stable/screen) or
  [tmux](https://packages.debian.org/stable/tmux)
* [scrot](https://packages.debian.org/stable/scrot)
* [xclip](https://packages.debian.org/stable/xclip)
* [colordiff](https://packages.debian.org/stable/colordiff)
* [git](https://packages.debian.org/stable/git)

### Software Packages used in Commented Code

Only in commented code (i.e. currently not used):

* Alternative window and session managers:
  * [i3](https://packages.debian.org/stable/i3-wm)
  * [flwm](https://packages.debian.org/stable/flwm)
  * [fvwm](https://packages.debian.org/stable/fvwm)
  * [lxsession](https://packages.debian.org/stable/lxsession)
  * [spectrwm](https://packages.debian.org/testing/spectrewm) (formerly
    [scrotwm](https://packages.debian.org/stable/scrotwm))
  * [stumpwm](https://packages.debian.org/stable/stumpwm)
  * [tritium](https://packages.debian.org/stable/tritium)
  * [notion](https://packages.debian.org/testing/notion)
* [loco](https://packages.qa.debian.org/loco) (no more in Debian) |
  [ccze](https://packages.debian.org/stable/ccze) |
  [lwatch](https://packages.debian.org/stable/lwatch) |
  [colortail](https://packages.debian.org/stable/colortail)
* [root-tail](https://packages.debian.org/stable/root-tail)
* [gnome-settings-daemon](https://packages.debian.org/stable/gnome-settings-daemon)

Other Configuration Files
-------------------------

The repository also contains some configuration files which I usually
want on every desktop, but which are more or less independent of the
desktop setup respectively could also be used on non-desktop machines.

* `colordiffrc` for [colordiff](https://packages.debian.org/stable/colordiff)
* `emacs.el` for [GNU Emacs](https://www.emacswiki.org/)
* `gitconfig` and `gitignore` for [Git](https://git-scm.org/)
* `lintianrc` for [lintian](https://packages.debian.org/stable/lintian)
* `screenrc` for [GNU Screen](https://www.gnu.org/software/screen/)

I’ll probably split them off into their separate repository somewhen
in the future, maybe using [vcsh](https://github.com/RichiH/vcsh).

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
* abe-desktop: Contains dependencies on all of the above plus optional
  dependencies on
  [other common metapackages](https://github.com/xtaran/abe-metapackages)
  I maintain.

Some of these packages recommend or suggest other metapackages which
previously were part of this repository but have been split off into
[their own git repository](https://github.com/xtaran/abe-metapackages).

### APT Repository

All those metapackages are usually also available from
[my APT repository](https://noone.org/apt/).
