use strict;
use warnings;

#�R�}���h���C�������̎��
my @nums = @ARGV;

#���v�����߂�T�u���[�`�����ďo��
my $total = sum(@nums);

#���v�̏o��
print "���v:$total\n";

#���v���v�Z����T�u���[�`��
sub sum {
	#�����̎󂯎��
	my @nums = @_;

	#�a�̌v�Z
	my $total = 0;
	foreach my $num (@nums) {
		$total += $num;
	}

	return $total;
}
