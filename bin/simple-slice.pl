#!/usr/bin/perl

use strict;
use warnings;

# enable slurp mode
local $/;

my $contents = <STDIN>;

# Find all [XXX!:...:XXX!] ("only") slices
while ($contents =~ m(\[([^!:]+)!:.*?:\1!\])gs) {
    my $slice = $1;
    if (grep { $_ eq $slice } @ARGV) {
	$contents =~ s(\[$slice!:(.*?):$slice!\])($1)gs;
    } else {
	$contents =~ s(\[$slice!:.*?:$slice!\])()gs;
    }
}

# Find all [!XXX:...:!XXX] ("not") slices
foreach my $slice (@ARGV) {
    $contents =~ s(\[!$slice:.*?:!$slice\])()gs;
}
$contents =~ s(\[!([^!:]+):(.*?):!\1\])($2)gs;

# Find all top level slices
foreach my $slice (@ARGV) {
    $contents =~ s(\[(([^:]+\+)?$slice(\+[^:]+)?):(.*?):\1\])($4)gs;
}
$contents =~ s(\[([^!:]+):.*?:\1\])()gs;

print $contents;
