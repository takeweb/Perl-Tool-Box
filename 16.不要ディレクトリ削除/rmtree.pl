use strict;
use warnings;
use File::Find;
use File::Path;

my @pathArray;
my $ref_err;

#�����őΏۃf�B���N�g�����󂯎��A
#find�ֈ����n��
find(\&wanted, $ARGV[0]);

#�f�B���N�g���폜
my $ret = rmtree(@pathArray, {error => \$ref_err});
foreach(@$ref_err) {
	my ($file, $message) = each(%$_);
	print "file" . $file . "message" . $message . "\n";
}

#�ċA�ďo�֐�
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

