use strict;
use warnings;

my @array = ('a', 'b', 'c', 'd');
my @ins;
my $header = "pppp";

push(@ins, $header);
my @removed = splice(@array, 2, 0, @ins);

print "array=@array\n";
print "removed=@removed\n";

