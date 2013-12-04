use strict;
use warnings;

my $temp;

while (my $line = <>) {
    chomp $line;
    $temp = $temp . ',' . $line;
}

print $temp;
