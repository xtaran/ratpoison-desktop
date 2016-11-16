#!/bin/sh

# Script to setup all the symbolic links necessary to make this setup
# work.

cd "$(dirname "$0")"
cd ..
BASE_PATH="$(pwd)"
REL_BASE_PATH=$(echo "$BASE_PATH" | sed -e "s:^${HOME}/::")

cat "$BASE_PATH/symlinks" | while read target arrow source; do
    target=$(echo "$target" | sed -e "s:^~:${HOME}:")

    if [ "$arrow" != "→" -o -z "$target" -o -z "$source" ]; then
	echo "Warning: Skipping '$target $arrow $source' as I can't parse it"
	continue
    fi

    if [ -e "$target" ]; then
	echo "Notice: $target already exists, skipping it"
	continue
    fi

    if [ ! -e "$BASE_PATH/$source" ]; then
	echo "Error: $source does not exist exist"
	exit 1
    fi

    ln -vis "$REL_BASE_PATH/$source" "$target"
done
