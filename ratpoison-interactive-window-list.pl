#!/usr/bin/perl -w

# Interactive window list replacement for ratpoison's "windows"
# command
#
# Copyright (C) 2008 by Axel Beckert, licensed under the GPLv3

### CONFIG

my @ratmenu_options = (qw(-font -misc-fixed-medium-r-*-*-13-*-*-*-*-60-iso10646-1),
		       qw(-fg orange -bg black -style dreary),
		       '-label', 'ratmenu: ratpoison window list');
my @ratmen_options = (qw(-F -misc-fixed-medium-r-*-*-13-*-*-*-*-60-iso10646-1),
		      qw(--foreground orange --background black -s dreary),
		      '-t', 'ratmenu: ratpoison window list');

### CODE

# Read original window list -- Could be done more elegant
my @windowlist = split(/\n/, `ratpoison -c windows`);

# Check if there are any windows, if not simulate ratpoison's
# behaviour

if ($#windowlist == 0 and $windowlist[0] !~ /^\d/) {
    exec('ratpoison', '-c', 'echo No managed windows');

# Else create a window list sorted and suitable for ratmenu
} else {
    my %windowlist = map { /^(\d+)/ => $_ } @windowlist;
    @windowlist = map { $windowlist{$_} => "ratpoison -c 'select $_'" }
		  sort { $a <=> $b }
		  keys %windowlist;

    # Search window which would be next by default
    my $io = 0;
    my $found = 0;
    for my $i (@windowlist) {
	$io++ if $i =~ /^\d/;
	if ($i =~ /^\d+\+/) {
	    $found = 1;
	    last;
	}
    }
    $io = 1 unless $found;

#    exec('ratmenu', @ratmenu_options, '-io', $io, @windowlist);
    exec('ratmen', @ratmen_options, '-i', $io, @windowlist);
}
