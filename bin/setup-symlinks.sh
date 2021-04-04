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

    if echo "$source" | egrep -q '^/'; then
        rel_source="$source"
        abs_source="$source"
    else
        rel_source="$REL_BASE_PATH/$source"
        abs_source="$BASE_PATH/$source"
    fi

    target_base_dir="$(dirname "$target")"
    mkdir -pv "$target_base_dir"

    if [ ! -e "$abs_source" ]; then
	echo "Error: $source does not exist exist"
	exit 1
    fi
    ln -vis "$rel_$source" "$target"
done
