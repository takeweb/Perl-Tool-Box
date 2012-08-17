#/usr/bin/perl

use strict;
use warnings;
use File::Path 'mkpath';

# コマンドライン引数の受取
# $ARGV[0]⇒$nendo : 作成したい年度
# $ARGV[1]⇒$mode : モード(0:ノーマル 1:前半後半付加)
my ($nendo,$mode) = @ARGV;

# 変数宣言
my $year;   # 年格納用
my $mnth;	# 月格納用
my $dir;	# ディレクトリ名格納用

$year = $nendo;

# 年度ディレクトリ作成
for (my $i = 0; $i < 12; $i++) {
	if ($i < 9) {
		$mnth = $i + 4;
	} elsif ($i >= 9) {
		if ($i == 9) {
			$year = $year + 1;
		}
		$mnth = $i - 8;
	}

	# 月編集
	$mnth = sprintf("%02d", $mnth);

	# ディレクトリ名編集
	$dir = $year . "年". $mnth . "月";

	# ディレクトリ作成
	if ($mode == 0) {
        $dir = $nendo . '年度/' . $dir;
        mkpath $dir or die "Cannot create dir: $!";
    } else {
        $dir = $nendo . '年度/' . $dir;
        mkpath $dir . "前半" or die "Cannot create dir: $!";
        mkpath $dir . "後半" or die "Cannot create dir: $!";
    }
}
