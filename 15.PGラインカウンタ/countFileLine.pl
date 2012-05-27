#!perl

use strict;
use warnings;
use File::Find;

########################################################
# �v���O�������C���J�E���^
#    ��P����:  �����Ώۃp�X
#    �o��:      �t�@�C�����X�g(�t�@�C����,�s��:)
########################################################

find(\&wanted, $ARGV[0]);

sub wanted {
	my $cnt = 0;
	my $match = 0;
	my $path = $File::Find::name;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/;
#	return unless $path =~ /\.java$/;
	return unless $path =~ /\.xml$/;
	return unless (-f $path);

	print $path;
	open my $fl, '<', $path or die "Can't open file :$!";
	while (my $line = <$fl>) {
		# �����s�R�����g
		if ($line =~ /^\t*\<\!\-\-.+\*$/) {
			$match = 1;
#print "match1:$line\n";
		} elsif ($line =~ /^ *\*\*/) {
			$match = 0;
			next;
#print "match2:$line\n";
		}

		next if $match == 1;
		next if $line =~ /^\n/;
#		next if $line =~ /\//;
#		next if $line =~ /\*/;
#		next if $line =~ /^\-/;
#		next if $line =~ /^PD/;
		next if $line =~ /^\t*\<\!\-\-.+\-\-\>$/;

		$cnt++;
	}
	close $fl;
	print ",";
	print "�s��:$cnt\n";
}
