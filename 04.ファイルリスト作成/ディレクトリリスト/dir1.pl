use strict;
use warnings;

my $hline = '-' x 30 . "\n";
my $dirname = '.';

opendir(DIR, $dirname) or die "$dirname: $!";

while (my $dir = readdir(DIR)) {
	next unless (-f $dir);
	next unless ($dir =~ /\.bat$/);
	print $hline;
	print $dir, "\n";
	print $hline;
	open(FILE, $dir) or die "$dir: $!";
	while (my $line = <FILE>) {
		print $line;
	}
	close(FILE);
}
