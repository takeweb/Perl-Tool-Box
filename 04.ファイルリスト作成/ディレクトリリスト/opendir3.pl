use strict;
use warnings;
use File::Find;

my @directories = ('./');

find(\&wanted, @directories);

sub wanted{
	print $File::Find::dir, '/';
	print "$_\n";
}
