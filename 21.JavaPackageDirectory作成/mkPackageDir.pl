#!perl

use strict;
use warnings;
use File::Path 'mkpath';

# �R�}���h���C�������̎��
# $ARGV[0]��$package : �f�B���N�g�����쐬������Java�p�b�P�[�W��
#           ex. jp.co.ricoh.is.terje.sub

# �ϐ��錾
my ($dir, $package) = @ARGV; # �����󂯎��
#my $dir = "src";            # �f�B���N�g�����i�[�p
my @sub_dirs = split(/\./, $package);	# �u.�v�ŕ������Ĕz��֊i�[

# �f�B���N�g�����쐬
foreach my $sub_dir (@sub_dirs) {
    $dir = $dir . '/' . $sub_dir;
}

print "$dir\n";

# �f�B���N�g���p�X�쐬
mkpath $dir or die "Cannot create dir: $!";

