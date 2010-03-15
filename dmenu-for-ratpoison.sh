#!/bin/sh

# Obvoius dmenu / demnu_path wrapper
#
# Copyright (C) 2008 by Axel Beckert, licensed under the GPLv3

exec `dmenu_path | dmenu -b -fn fixed -nb black -nf orange -sb orange -sf black`
