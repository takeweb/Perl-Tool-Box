use strict;
use warnings;
use utf8;

#######################################################
# IM-共通マスタアカウントXML作成
#    第１引数:  ユーザ情報ファイル名
#    標準出力： 出力ファイルに結果をリダイレクト
########################################################

my $file_so = $ARGV[0];
my $offset = 0;
my $sort_key = 0;
my @department_cds;
my $index = 0;

# 共通設定値
my $first_day_of_week = "1";
my $encoding = "";
my $time_zone_id = "";
my $calendar_id = "";
my $login_failure_count = "0";
my $notes = "";
my $valid_start_date = "Jan 1, 1900 00:00:00 AM";
my $valid_end_date = "Jan 1, 3000 00:00:00 AM";
my $account_attribute_key = "im_first_login";
my $account_attribute_val = "true";
my $account_license = "true";

$\ = "\n";

# ヘッダ出力
print "\<\?xml version\=\"1.0\" encoding\=\"UTF-8\"\?\>";
print "\<root xmlns\=\"http\:\/\/intra-mart\.co\.jp\/system\/admin\/account\/account-data\"\>";

# ユーザ情報ファイルを読み込み
open my $fh, '<', $file_so or die qq/Can't open file "$file_so" : $!/;

while (my $row = <$fh>) {
    next if $row =~ /^\n/;
    next if $row =~ /^--/;
    next if $. == 1;

    $sort_key = $offset + $index;

    chomp($row);
    # ユーザコード取得
    my ($user_cd) = split(/\,/, $row);

    print "    \<account-data cd=\"$user_cd\"\>";
    print "        \<password\>$user_cd\</password\>";
    print "        \<first-day-of-week\>$first_day_of_week\</first-day-of-week\>";
    print "        \<encoding\>$encoding\</encoding\>";
    print "        \<time-zone-id\>$time_zone_id\</time-zone-id\>";
    print "        \<calendar-id\>$calendar_id\</calendar-id\>";
    print "        \<login-failure-count\>$login_failure_count\</login-failure-count\>";
    print "        \<notes\>$notes\</notes\>";
    print "        \<valid-start-date\>$valid_start_date\</valid-start-date\>";
    print "        \<valid-end-date\>$valid_end_date\</valid-end-date\>";
    print "        \<account-attributes\>";
    print "            \<account-attribute key=\"$account_attribute_key\" value=\"$account_attribute_val\">\</account-attribute\>";
    print "        \<\/account-attributes\>";
    print "        \<account-license\>$account_license\</account-license\>";
    print "    \<\/account-data\>";
}
close $fh;

# フッタ出力
print "\<\/root\>";