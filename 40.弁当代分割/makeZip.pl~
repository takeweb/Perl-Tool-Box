use strict;
use warnings;
use utf8;

while (my $line = <>) {
    next if $line =~ /^\n/;
    
    chomp $line;
    
    if ($line =~ /INSERT \[dbo\]\.\[SD/) {
	print "$line\n";
    }
}
