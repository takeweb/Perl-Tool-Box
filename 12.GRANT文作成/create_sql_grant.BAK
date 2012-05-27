use strict;
use warnings;

#######################################################
# GRANT文作成
#    第１引数:  スキーマ名
#    第２引数:  元ファイル名
#    標準出力： SQLファイルにSQL文リダイレクト
########################################################

my $schema = $ARGV[0];
my $file = $ARGV[1];

print "SET ECHO ON\n";
print "SET LINE 300\n";
print "set timing on\n";
print "spool grant.log\n";

#テーブルリストを読み込み
open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;
while (my $table = <$fh>) {
    next if $table =~ /^\n/;
    next if $table =~ /^--/;

    chomp($table);
    print "GRANT SELECT ON $table TO $schema;\n";
}
close $fh;
print "spool off\n";
print "exit\n";

