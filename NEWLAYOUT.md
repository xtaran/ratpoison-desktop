New Layout for Axel's $HOME Configuration
=========================================

  * Switch to using [vcsh](https://github.com/RichiH/vcsh)

Splitting Up and Moving Around Directories
------------------------------------------

### Configuration files for commandline/text-mode applications

    ~/.ratpoison/colordiffrc → ~/.colordiffrc         (cli)
    ~/.ratpoison/screenrc    → ~/.screenrc            (cli)

### Configuration files for package development

    ~/.ratpoison/lintianrc   → ~/.lintianrc           (pkgdev)

### Configuration files for the desktop

    ~/.ratpoison/xsession    →  ~/.Xsession          (x)
    ~/.ratpoison/ratpoisonrc → ~/.ratpoisonrc        (x)
    ~/.ratpoison/keynavrc    → ~/.keynavrc           (x)
    ~/.ratpoison             → /.config/abe/desktop/ (x)

etc.

### Configuration files for Emacs

    ~/.ratpoison/emacs.el    → ~/.emacs               (emacs)
    ~/.emacs.d               → ~/.config/emacs/       (emacs)

### Configuration files for Zsh

    ~/.zsh/zshrc             → ~/.zshrc               (zsh)
    ~/.zsh/zshenv            → ~/.zshenv              (zsh)
    ~/.zsh/history           → ~/.local/zsh/history   (-, should be persisent)
    ~/.zsh/dirs              → ~/.cache/zsh/dirs      (-, should not be persisent)
    ~/.zsh/zsh.d             → ~/.config/zsh/         (zsh, needs consolidation for speed)

What to do with submodules is still open. `grml-etc-core` will vanish
as soon as a `grml-zshrc` package is available.

Ideas
-----

  * Maybe using
    [RichiH's vcsh mr template](https://github.com/RichiH/vcsh_mr_template/tree/master/.config/mr)
    to ease bootstrapping.
