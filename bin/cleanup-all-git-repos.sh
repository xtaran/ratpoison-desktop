#!/bin/sh

# See also http://metalinguist.wordpress.com/2007/12/06/the-woes-of-git-gc-aggressive-and-how-git-deltas-work/

pwd="$(pwd)"
find "$@" -name .git | while read i; do
    cd "$i/.."
    du -sh "$(pwd)"
    git repack -a -d --depth=250 --window=250
    git gc
    du -sh "$(pwd)"
    cd "$pwd"
done
