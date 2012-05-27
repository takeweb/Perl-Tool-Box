#!perl

use strict;
use warnings;
use File::Path 'mkpath';

=pod ###################################################################
 年度ディレクトリ作成

 $ARGV[0]⇒$nendo : 	作成したい年度
 $ARGV[1]⇒$mode : 		モード(0:ノーマル 1:前半後半付加)
 $ARGV[2]⇒$basedir : 	ディレクトリを作成するベースのディレクトリ
=cut ###################################################################

# 変数宣言
my $year;   # 年格納用
my $mnth;	# 月格納用
my $dir;	# ディレクトリ名格納用

# コマンドライン引数の受取
my ($nendo,$mode,$basedir) = @ARGV;

$year = $nendo;
#$basedir =~ s/\\/\//g;

# 年度ディレクトリ作成
for (my $i = 4; $i < 16; $i++) {
	$mnth = $i;
	if ($i >= 13) {
		if ($i == 13) {
			$year = $year + 1;
		}
		$mnth = $i - 12;
	}

	# 月編集
	$mnth = sprintf("%02d", $mnth);

	# ディレクトリ名編集
	$dir = $year . "年". $mnth . "月";

	# ディレクトリ作成
	$dir = $basedir . '/' . $nendo . '年度/' . $dir;
	if ($mode == 0) {
		mkpath $dir or die "Cannot create dir: $!";
	} else {
		mkpath $dir . "前半" or die "Cannot create dir: $!";
		mkpath $dir . "後半" or die "Cannot create dir: $!";
	}
}
