#!/usr/bin/perl -w

# Config file wrapper around dmenu
#
# Copyright (C) 2008, 2010 by Axel Beckert, licensed under the GPLv3

### CONFIG

my $config = "$ENV{HOME}/.ratpoison/dmenu-abe.rc";
my $cache  = "$ENV{HOME}/.dmenu_cache";
my @dmenu_options = qw(-p » -i -b -fn fixed -nb black -nf orange -sb orange -sf black);

### INIT

use IPC::Open2;

my %command;
my %whichcache;

### CHECK

die "$config not found or unreadable" unless (-f $config &&  -r _);

### CHECK AND READ CACHE
if (!-e $cache) {
    system("dmenu_path > /dev/null");
    if (!-e $cache) {
	die "Couldn't create cache file $cache: $!";
    }
}

open(CACHE, '<', $cache) or die "Can't open $cache: $!";
while ($_ = <CACHE>) {
    chomp;
    $whichcache{$_} = 1;
}
close(CACHE);

### READ
open(CONFIG, '<', $config) or die "Can't open $config: $!";
while ($_ = <CONFIG>) {
    next if /^\s*$|^\#/;
    chomp;
    die "Wrong syntax in $config, should be 'description => command', found:
Line $.: $_" unless /=>/;
    my ($desc, $call) = split(/\s*=>\s*/);
    my $modcall = $call;
    $modcall =~ s/'.*?'|".*?"/bla/g;
    my ($program, @args) = split(/\s/, $modcall);
    if ($program eq 'env') {
	while (@args) {
	    if ($args[0] =~ /=/) {
		shift @args;
	    } else {
		$program = $args[0];
		last;
	    }
	}
    }
    if ($whichcache{$program} or $program =~ m(/)) {
	$command{$desc} = $call;
    } else {
	#print STDERR "Not found: $program ($modcall)\n";
    }
}
close(CONFIG);

### GENERATE

open2(\*DMENU_OUT, \*DMENU_IN, 'dmenu', @dmenu_options)
    or die "Can't pipe to and from 'dmenu ".join(' ',@dmenu_options)."': $!";
print DMENU_IN join("\n", sort keys %command);
close(DMENU_IN);

### RECEIVE

my $result = <DMENU_OUT>;
exit unless $result;
chomp($result);

### EXECUTE

my $xmessage;
foreach  my $xm (qw(gmessage xmessage gxmessage)) {
    if ($whichcache{$xm}) {
	$xmessage = $xm;
	last;
    }
}

fork && exit;
if (system($command{$result} || $result)) {
    my $message =
	"Couldn't execute ".
	($command{$result} || $result).
	": $!";

    if ($xmessage) {
	system($xmessage, $message);
    } else {
	die $message;
    }
}
