#!perl

use strict;
use warnings;

########################################################
# �N���f�B���N�g���쐬
#    ��P����:  �쐬�Ώ۔N�x
#    �o��:      �N�x���ԃf�B���N�g����12�쐬�����
#
########################################################

# �R�}���h���C�������̎��
#my ($year) = @ARGV;
my ($year) = shift @ARGV;

# �ϐ��錾
my $mnth;	# ���i�[�p
my $dir;	# �f�B���N�g�����i�[�p

# �N�x�f�B���N�g���쐬
# $i�@0:4���A 1:5���A�c�A 8:12��
# �@�@9:1���A10:2���A11: 3��
for (my $i = 0; $i < 12; $i++) {
	# 12���܂�
	if ($i < 9) {
		$mnth = $i + 4;

	# ���N1������
	} elsif ($i >= 9) {
		if ($i == 9) {
			$year = $year + 1;
		}
		$mnth = $i - 8;
	}

	# ���ҏW
	$mnth = sprintf("%02d", $mnth);

	# �f�B���N�g�����ҏW
	$dir = $year . "�N". $mnth . "��";
	#print "$dir\n";

	# �f�B���N�g���쐬
	mkdir $dir or die "Cannot create dir: $!";
}
