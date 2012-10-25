TODO Metapackages
=================

* I need a "Recommends" level "Conflicts": abe-laptop should be
  installable without removing debconf-i18n, but should still
  encourage removing it. Potentially wanted on both, Ubuntu and
  Debian.
  
* Providing rsyslog, vim-tiny and debconf-i18n is only needed on
  Ubuntu. So this should go to an ubuntu-specific package which
  abe-laptop likely just Recommends.
