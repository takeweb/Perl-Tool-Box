use strict;
use warnings;

# �R�}���h���C���������󂯎��
my @nums = @ARGV;

# �a�̌v�Z
my $total = 0;
foreach my $num (@nums) {
	$total += $num;
}

# �v�Z���ʂ̏o��
print "Total:$total\n";

