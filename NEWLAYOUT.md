New Layout for Axel's Desktop Configuration
===========================================

Splitting Up and Moving Around Directories
------------------------------------------

    ~/.ratpoison → ~/.config/abe/desktop/
                 → ~/.config/abe/commandline/
                 → ~/.config/emacs/
    ~/.zsh       → ~/.config/zsh/
    ~/.mrconfig  → ~/.config/mr/{config,available}.d/

Ideas
-----

  * [RichiH's vcsh mr template](https://github.com/RichiH/vcsh_mr_template/tree/master/.config/mr)

Open Issues
-----------

  * Where to put `bin/setup-symlinks.sh` and `symlinks`?
    * `bin/setup-symlinks.sh` and `symlinks` could become part of
      `~/.config/mr/`
    * Each repo needs it's own `symlinks` file and either
      `~/.config/mr/` or `~/.config/abe/commandline/` contains
      `bin/setup-symlinks.sh`.
