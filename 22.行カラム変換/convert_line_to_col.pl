use strict;
use warnings;

my $col1 = '';
my $col2 = '';
my $col3 = '';
my $col4 = '';
my $cnt = 0;

while (my $line = <>) {
    chomp $line;

    $cnt++;

    if ( $cnt == 1 ) {
	$col1 = $line;
    } elsif ( $cnt == 2 ) {
	$col2 = $line;
    } elsif ( $cnt == 3 ) {
	$col3 = $line;
    } elsif ( $cnt == 4 ) {
	$col4 = $line;

	print "$col1,";
	print "$col2,";
	print "$col3,";
	print "$col4\n";

	$cnt = 0;
	$col1 = '';
	$col2 = '';
	$col3 = '';
	$col4 = '';
    }
}
