use strict;
use warnings;

#######################################################
# Oracle統計情報取得分作成
#    第一引数:  スキーマ名
#    標準出力： SQLファイルにSQL文リダイレクト
# 「スキーマ名.txt」というテキストファイルに
#  スキーマに属する全てのテーブルを出力しておくこと。
########################################################

my $schema = $ARGV[0];
my $file = $schema . ".txt";

print "SET ECHO ON\n";
print "SET LINE 300\n";
print "set timing on\n";
print "spool GATHER_TABLE_STATS_$schema.log\n";

#テーブルリストを読み込み
open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;
while (my $table = <$fh>) {
    chomp($table);
    print "EXECUTE DBMS_STATS.GATHER_TABLE_STATS ( owner => '$schema', tabname => '$table', estimate_percent => 20, block_sample => TRUE, method_opt => 'FOR ALL COLUMNS SIZE 75', cascade => TRUE);\n";
}
close $fh;
print "spool off\n";
print "exit\n";

