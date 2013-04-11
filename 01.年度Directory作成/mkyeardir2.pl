#/usr/bin/perl

use strict;
use warnings;
use File::Path 'mkpath';

# �R�}���h���C�������̎��
# $ARGV[0]��$nendo : �쐬�������N�x
# $ARGV[1]��$mode : ���[�h(0:�m�[�}�� 1:�O���㔼�t��)
# $ARGV[2]��$targetdir : �t�H���_�쐬��
my ($nendo,$mode,$targetdir) = @ARGV;

# �ϐ��錾
my $year;   # �N�i�[�p
my $mnth;	# ���i�[�p
my $dir;	# �f�B���N�g�����i�[�p

$year = $nendo;

# �N�x�f�B���N�g���쐬
for (my $i = 0; $i < 12; $i++) {
	if ($i < 9) {
		$mnth = $i + 4;
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

	# �f�B���N�g���쐬
	$dir = $targetdir. '/�T��_' . $nendo . '�N�x/' . $dir;
#print $dir;
	if ($mode == 0) {
        mkpath $dir or die "Cannot create dir: $!";
    } else {
        mkpath $dir . "�O��" or die "Cannot create dir: $!";
        mkpath $dir . "�㔼" or die "Cannot create dir: $!";
    }
}
