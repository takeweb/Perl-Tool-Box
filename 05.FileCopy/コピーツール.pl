use strict;
use warnings;
use File::Copy;

## コピー元ディレクトリ
my $from_root = "C:/ohishi/07.GUARD対応/04_検証/RESQ/RESQ_V70/";
my $from_dir_H = "HSFUKU_H2009-001/EXE/";
my $from_dir_T = "HSFUKU_T2009-001/EXE/";
my $from_dir_sim = "C:/ohishi/07.GUARD対応/04_検証/RESQ/RESQ_V50/開発/ASIC_V130/EXE/";

## コピー先ディレクトリ
my $to_dir;
my $to_dir_search = "C:/Program Files/RESQ_NEW/EXE/";
my $to_dir_update = "C:/Program Files/RESQMnt/EXE/";
my $to_dir_sim = "C:/Program Files/ResqSim/EXE/";

## ファイルリスト
my $list;
my $list_search = "RESQ検索ツール.list";
my $list_update = "RESQ更新ツール.list";
my $list_sim = "RESQSIMツール.list";

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

# exeファイル名リストオープン
open(FILE, $list) or die $!;

while (my $exe_name = <FILE>) {
	chomp($exe_name);
#	print "$exe_name\t";
#	print "copy \"" . $from_dir . $exe_name . "\" , \"" . $to_dir . $exe_name . "\"\;", "\n";

	# 検索ツール、更新ツールの場合
	if ($ARGV[0] eq "S" or $ARGV[0] eq "U") {
		copy $from_root . $from_dir_H . $exe_name, $to_dir . $exe_name;
		copy $from_root . $from_dir_T . $exe_name, $to_dir . $exe_name;
	# ＳＩＭツールの場合
	} else {
		if ($exe_name eq "RZ01.exe" or $exe_name eq "RH05.exe") {
			copy $from_root . $from_dir_H . $exe_name, $to_dir_sim . $exe_name;
		} else {
			copy $from_dir_sim . $exe_name, $to_dir_sim . $exe_name;
		}
	}
}

# ファイルクローズ
close FILE;
