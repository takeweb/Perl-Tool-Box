use strict;
use warnings;
use File::Path;

#######################################################
# HULFT���擾
#    snd:  �z�M��`
#    rcv:  �W�M��`
#    job:  �W���u��`
#    hst:  �ڍ׃z�X�g��`
#    tgrp: �]���O���[�v��`
# HULFT���C���X�g�[������Ă���T�[�o�ł̂ݓ��삵�܂��B
# �܂�HULFT�̊��ϐ����ǂݍ��܂�Ă��邱�Ƃ��O��ł��B
########################################################

#########################
## ���C������
#########################

# ���ݎ����擾
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;
$mon = sprintf("%02d", $mon);
$mday = sprintf("%02d", $mday);
my $ymd = $year . $mon . $mday;

# ���[�h�Z�b�g
my @modes = ('snd', 'rcv', 'job', 'hst', 'tgrp');

# ���t�f�B���N�g���쐬
my $dir = $ymd;
if (-d $dir) {
    rmtree([$dir]);
}
mkpath $dir or die "Cannot create dir: $!";

# ��`�����t�@�C���֏o��
foreach my $mode (@modes) {
#   printf "utligen -f ./$dir/hulft_" . $mode . "_all_" . $ymd . "\.out -i " . $mode . " -id \"*\"";
    system "utligen -f ./$dir/hulft_" . $mode . "_all_" . $ymd . "\.out -i " . $mode . " -id \"*\"";
}

