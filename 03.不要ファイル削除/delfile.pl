use strict;
use warnings;
use File::Find;

#�����őΏۃf�B���N�g�����󂯎��A
#find�ֈ����n��
find(\&wanted, $ARGV[0]);

#�ċA�ďo�֐�
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.scc$|\.log$|\.bad$/;
	return unless $path =~ /\.csv$|\.CSV$|\.log$|\.LOG$|\.bad$|\.txt$/;

	print "$path\n";

	unlink $path;

}
