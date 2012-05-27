use strict;
use warnings;
use File::Find;

#引数で対象ディレクトリを受け取り、
#findへ引き渡し
find(\&wanted, $ARGV[0]);

#再帰呼出関数
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.scc$|\.log$|\.bad$/;
	return unless $path =~ /\.csv$|\.CSV$|\.log$|\.LOG$|\.bad$|\.txt$/;

	print "$path\n";

	unlink $path;

}
