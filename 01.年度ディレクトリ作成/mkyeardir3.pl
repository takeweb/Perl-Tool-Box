#!perl

use strict;
use warnings;
use File::Path 'mkpath';

=pod ###################################################################
 �N�x�f�B���N�g���쐬

 $ARGV[0]��$nendo : 	�쐬�������N�x
 $ARGV[1]��$mode : 		���[�h(0:�m�[�}�� 1:�O���㔼�t��)
 $ARGV[2]��$basedir : 	�f�B���N�g�����쐬����x�[�X�̃f�B���N�g��
=cut ###################################################################

# �ϐ��錾
my $year;   # �N�i�[�p
my $mnth;	# ���i�[�p
my $dir;	# �f�B���N�g�����i�[�p

# �R�}���h���C�������̎��
my ($nendo,$mode,$basedir) = @ARGV;

$year = $nendo;
#$basedir =~ s/\\/\//g;

# �N�x�f�B���N�g���쐬
for (my $i = 4; $i < 16; $i++) {
	$mnth = $i;
	if ($i >= 13) {
		if ($i == 13) {
			$year = $year + 1;
		}
		$mnth = $i - 12;
	}

	# ���ҏW
	$mnth = sprintf("%02d", $mnth);

	# �f�B���N�g�����ҏW
	$dir = $year . "�N". $mnth . "��";

	# �f�B���N�g���쐬
	$dir = $basedir . '/' . $nendo . '�N�x/' . $dir;
	if ($mode == 0) {
		mkpath $dir or die "Cannot create dir: $!";
	} else {
		mkpath $dir . "�O��" or die "Cannot create dir: $!";
		mkpath $dir . "�㔼" or die "Cannot create dir: $!";
	}
}
