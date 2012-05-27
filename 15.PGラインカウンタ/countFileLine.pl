#!perl

use strict;
use warnings;
use File::Find;

########################################################
# プログラムラインカウンタ
#    第１引数:  検索対象パス
#    出力:      ファイルリスト(ファイル名,行数:)
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
		# 複数行コメント
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
	print "行数:$cnt\n";
}
