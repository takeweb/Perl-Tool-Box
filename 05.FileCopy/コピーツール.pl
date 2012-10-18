use strict;
use warnings;
use File::Copy;

## �R�s�[���f�B���N�g��
my $from_root = "C:/ohishi/07.GUARD�Ή�/04_����/RESQ/RESQ_V70/";
my $from_dir_H = "HSFUKU_H2009-001/EXE/";
my $from_dir_T = "HSFUKU_T2009-001/EXE/";
my $from_dir_sim = "C:/ohishi/07.GUARD�Ή�/04_����/RESQ/RESQ_V50/�J��/ASIC_V130/EXE/";

## �R�s�[��f�B���N�g��
my $to_dir;
my $to_dir_search = "C:/Program Files/RESQ_NEW/EXE/";
my $to_dir_update = "C:/Program Files/RESQMnt/EXE/";
my $to_dir_sim = "C:/Program Files/ResqSim/EXE/";

## �t�@�C�����X�g
my $list;
my $list_search = "RESQ�����c�[��.list";
my $list_update = "RESQ�X�V�c�[��.list";
my $list_sim = "RESQSIM�c�[��.list";

$to_dir = "";
$list = "";
if ($ARGV[0] eq "S") {
	$to_dir = $to_dir_search;
	$list = $list_search;
} elsif ($ARGV[0] eq "U") {
	$to_dir = $to_dir_update;
	$list = $list_update;
} else {
	$to_dir = $to_dir_sim;
	$list = $list_sim;
}

# exe�t�@�C�������X�g�I�[�v��
open(FILE, $list) or die $!;

while (my $exe_name = <FILE>) {
	chomp($exe_name);
#	print "$exe_name\t";
#	print "copy \"" . $from_dir . $exe_name . "\" , \"" . $to_dir . $exe_name . "\"\;", "\n";

	# �����c�[���A�X�V�c�[���̏ꍇ
	if ($ARGV[0] eq "S" or $ARGV[0] eq "U") {
		copy $from_root . $from_dir_H . $exe_name, $to_dir . $exe_name;
		copy $from_root . $from_dir_T . $exe_name, $to_dir . $exe_name;
	# �r�h�l�c�[���̏ꍇ
	} else {
		if ($exe_name eq "RZ01.exe" or $exe_name eq "RH05.exe") {
			copy $from_root . $from_dir_H . $exe_name, $to_dir_sim . $exe_name;
		} else {
			copy $from_dir_sim . $exe_name, $to_dir_sim . $exe_name;
		}
	}
}

# �t�@�C���N���[�Y
close FILE;
