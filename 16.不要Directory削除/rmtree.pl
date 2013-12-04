use strict;
use warnings;
use File::Find;
use File::Path;

my @pathArray;
my $ref_err;

#引数で対象ディレクトリを受け取り、
#findへ引き渡し
find(\&wanted, $ARGV[0]);

#ディレクトリ削除
my $ret = rmtree(@pathArray, {error => \$ref_err});
foreach(@$ref_err) {
	my ($file, $message) = each(%$_);
	print "file" . $file . "message" . $message . "\n";
}

#再帰呼出関数
sub wanted{
	my $path = $File::Find::name;

	return unless $path =~ /\.svn$|\.settings$|\.amateras$|\.classpath$|\.project$|\.tomcatplugin$|\.cvsignore$|\.sdf\.wsp$/;

	print "$path\n";

	if ( $path =~ /\.svn$|\.settings$/ ) {
		push(@pathArray, $path);
	} else {
		unlink $path;
	}
}

