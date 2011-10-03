#!/usr/bin/perl
# Inspired by RSE's slice, it's way simpler, but supports negation in
# the input.

use strict;
use warnings;

# enable slurp mode
local $/;

my $contents = <STDIN>;

# Find all [XXX!:...:XXX!] ("only") slices
while ($contents =~ m(\[([^!:]+)!:.*?:\1!\])gs) {
    my $slice = $1;
    if (grep { $slice =~ /^(.*\+)?$_(\+.*)?$/ } @ARGV) {
	$contents =~ s(\[\Q$slice\E!:(.*?):\Q$slice\E!\])($1)gs;
    } else {
	$contents =~ s(\[\Q$slice\E!:.*?:\Q$slice\E!\])()gs;
    }
}

# Find all [!XXX:...:!XXX] ("not") slices
foreach my $slice (@ARGV) {
    $contents =~ s(\[!(([^:]+\+)?$slice(\+[^:]+)?):.*?:!\1\])()gs;
}
$contents =~ s(\[!([^!:]+):(.*?):!\1\])($2)gs;

# Find all top level slices
foreach my $slice (@ARGV) {
    $contents =~ s(\[(([^:]+\+)?$slice(\+[^:]+)?):(.*?):\1\])($4)gs;
}
$contents =~ s(\[([^!:]+):.*?:\1\])()gs;

print $contents;
