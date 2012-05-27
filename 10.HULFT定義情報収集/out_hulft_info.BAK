use strict;
use warnings;
use File::Path;

#######################################################
# HULFT情報取得
#    snd:  配信定義
#    rcv:  集信定義
#    job:  ジョブ定義
#    hst:  詳細ホスト定義
#    tgrp: 転送グループ定義
# HULFTがインストールされているサーバでのみ動作します。
# またHULFTの環境変数が読み込まれていることが前提です。
########################################################

#########################
## メイン処理
#########################

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;
$mon = sprintf("%02d", $mon);
$mday = sprintf("%02d", $mday);
my $ymd = $year . $mon . $mday;

# モードセット
my @modes = ('snd', 'rcv', 'job', 'hst', 'tgrp');

# 日付ディレクトリ作成
my $dir = $ymd;
if (-d $dir) {
    rmtree([$dir]);
}
mkpath $dir or die "Cannot create dir: $!";

# 定義情報をファイルへ出力
foreach my $mode (@modes) {
#   printf "utligen -f ./$dir/hulft_" . $mode . "_all_" . $ymd . "\.out -i " . $mode . " -id \"*\"";
    system "utligen -f ./$dir/hulft_" . $mode . "_all_" . $ymd . "\.out -i " . $mode . " -id \"*\"";
}

