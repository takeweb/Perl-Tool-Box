#!perl

use strict;
use warnings;
use File::Path 'mkpath';

# コマンドライン引数の受取
# $ARGV[0]⇒$package : ディレクトリを作成したいJavaパッケージ名
#           ex. jp.co.ricoh.is.terje.sub

# 変数宣言
my ($dir, $package) = @ARGV; # 引数受け取り
#my $dir = "src";            # ディレクトリ名格納用
my @sub_dirs = split(/\./, $package);	# 「.」で分割して配列へ格納

# ディレクトリ名作成
foreach my $sub_dir (@sub_dirs) {
    $dir = $dir . '/' . $sub_dir;
}

print "$dir\n";

# ディレクトリパス作成
mkpath $dir or die "Cannot create dir: $!";

