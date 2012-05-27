use strict;
use warnings;
use File::Path;

#######################################################
# HULFT配信、集信 実績情報取得
#    snd: 配信情報 対象のHULFT-IDをsnd_list.txtへ記述
#    rcv: 集信情報 対象のHULFT-IDをrcv_list.txtへ記述
# HULFTがインストールされているサーバでのみ動作します。
# またHULFTの環境変数が読み込まれていることが前提です。
########################################################

#########################
## メイン処理
#########################

# 引数に「all」と指定されたら、全部
# それ以外はファイルリストにあるHULFT-IDを対象とする
my $all = shift;

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;
$mon = sprintf("%02d", $mon);
$mday = sprintf("%02d", $mday);
my $ymd = $year . $mon . $mday;

# 日付ディレクトリ作成
my $dir = $ymd;
unless (-d $dir) {
    mkpath $dir or die "Cannot create dir: $!";
}

# HULFT配信実績、集信実績情報取得
foreach my $mode ('s', 'r') {
    # ファイル名決定
    my $file;
    my $out;
    if ($mode eq 's') {
        $file = 'snd_list.txt';
        $out = 'snd_result.txt';
    } else {
        $file = 'rcv_list.txt';
        $out = 'rcv_result.txt';
    }

    if ($all eq 'all') {
        system "utllist -$mode > .\/" . $ymd . "\/" . $out;
    } else {
        # HULFT IDファイルを読込ながら、実績情報取得
        open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;
        while (my $hulft_id = <$fh>) {
            chomp($hulft_id);
            system "utllist -$mode -f $hulft_id >> .\/" . $ymd . "\/" . $out;
        }
        close $fh;
    }
}
