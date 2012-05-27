use strict;
use warnings;

#######################################################
# ゼロクリア文作成
#    第一引数:  スキーマ名
#    標準出力： SQLファイルにSQL文リダイレクト
# 「スキーマ名.txt」というテキストファイルに
#  スキーマに属する全てのテーブルを出力しておくこと。
########################################################

my $file = $ARGV[0];

#テーブルリストを読み込み
open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;
while (my $row = <$fh>) {
    chomp($row);
    print "cp /dev/null $row\n";
}
close $fh;

