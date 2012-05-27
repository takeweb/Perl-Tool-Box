#!perl

use strict;
use warnings;
use File::Find;

	my $cnt = 0;
	my $match = 0;
	my $path = $ARGV[0];

	open my $fl, '<', $path or die "Can't open file :$!";
	while (my $line = <$fl>) {
		# •¡”sƒRƒƒ“ƒg
		if ($line =~ /^\t*\<\!\-\-.+\*$/) {
			$match = 1;
print "match1:$line\n";
		} elsif ($line =~ /^\*\*/) {
			$match = 0;
print "match2:$line\n";
			next;
		}

		next if $match == 1;
		next if $line =~ /^\n/;
#		next if $line =~ /\//;
#		next if $line =~ /\*/;
#		next if $line =~ /^\-/;
#		next if $line =~ /^PD/;
		next if $line =~ /^\t*\<\!\-\-.+\-\-\>$/;

		print $line;
	}
	close $fl;

	