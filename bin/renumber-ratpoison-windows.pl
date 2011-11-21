#!/usr/bin/perl -wl

use strict;

my %data = (
    q/root@nemo:/ => 0,
    q/.* - Conkeror$/ => 1,
    q/abe@nemo: autossh -t sym 'screen -RdU'/ => 2,
    q/abe@nemo: autossh -t (kiva6|virt2) 'screen -RdU'/ => 3,
    q(abe@nemo: logread -f) => 4,
    q(ftp\.ch\.debian\.org: rsync/ftpsync log$) => 5,
    q/emacs\@nemo\.deuxchevaux\.org$/ => 10,
);

my $issues = 1;
issue: while ($issues) {
    my $ratpoison_windows = `ratpoison -c windows`;
    foreach my $check (keys %data) {
	if ($ratpoison_windows !~ /^($data{$check})\D$check/m and
	    $ratpoison_windows =~ /^([0-9]+)\D($check)/m and
	    $1 != $data{$check}) {
	    print "$1 => $data{$check} ($2)";
	    system(qw(ratpoison -c), "number $data{$check} $1");
	    next issue;
	}
    }
    $issues = 0;
}
