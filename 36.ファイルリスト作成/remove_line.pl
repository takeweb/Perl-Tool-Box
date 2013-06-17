use strict;
use warnings;

my $keep = "";
my $out = "";

while (my $line = <>) {
    chomp $line;
    my $current = substr($line, 0, 7);
    
    if ( $keep eq $current  ) {
	$out = $out . "," . $line;
    } else {
	print "$out\n";
	$out = $line;
	$keep = $current;
    }
}
