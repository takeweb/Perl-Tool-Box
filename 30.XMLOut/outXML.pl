use strict;
use warnings;
use utf8;

#######################################################
# IM-共通マスタ組織XML文作成
#    第１引数:  組織データファイル名
#    第２引数： 組織・役職データファイル名
#    標準出力： 出力ファイルに結果をリダイレクト
########################################################

my $file = $ARGV[0];
my $file_soyaku = $ARGV[1];
my $cnt = 6;
my $start_date = "1900-01-01";
my $end_date = "3000-01-01";

# ヘッダ出力
print "\<\?xml version\=\"1.0\" encoding\=\"UTF-8\"\?\>\n";
print "\<root xmlns\=\"http\:\/\/intra-mart\.co\.jp\/system\/master\/company\"\>\n";
print "    \<company company-cd\=\"10\"\>\n";
print "        \<department-set department-set-cd\=\"10\"\>\n";

# 組織リストを読み込み
open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;

while (my $row = <$fh>) {
    next if $row =~ /^\n/;
    next if $row =~ /^--/;

    chomp($row);
    # 組織コード、組織名称の取り出し　タブ区切り
    my ($col1, $col2) = split(/\s+/, $row);

    print "            \<department department-cd\=\"$col1\" sort-key\=\"$cnt\"\>\n";
    print "                \<term start-date\=\"$start_date\" end-date\=\"$end_date\" delete-flag\=\"false\"\>\n";
    print "                    \<locale locale-id\=\"ja\"\>\n";
    print "                        \<department-name\>$col2\<\/department-name\>\n";
    print "                        \<department-short-name\>$col2\<\/department-short-name\>\n";
    print "                        \<department-search-name\>\<\/department-search-name\>\n";
    print "                        \<country-cd\>\<\/country-cd\>\n";
    print "                        \<zip-code\>\<\/zip-code\>\n";
    print "                        \<address1\>\<\/address1\>\n";
    print "                        \<address2\>\<\/address2\>\n";
    print "                        \<address3\>\<\/address3\>\n";
    print "                        \<telephone-number\>\<\/telephone-number\>\n";
    print "                        \<extension-number\>\<\/extension-number\>\n";
    print "                        \<fax-number\>\<\/fax-number\>\n";
    print "                        \<extension-fax-number\>\<\/extension-fax-number\>\n";
    print "                        \<email-address1\>\<\/email-address1\>\n";
    print "                        \<email-address2\>\<\/email-address2\>\n";
    print "                        \<url\>\<\/url\>\n";
    print "                        \<notes\>\<\/notes\>\n";
    print "                    \<\/locale\>\n";
    print "                \<\/term\>\n";


    # 組織リストを読み込み
    open my $fh2, '<', $file_soyaku or die qq/Can't open file $file_soyaku : $!/;

    while (my $row2 = <$fh2>) {
	
	next if $row2 =~ /^\n/;
	next if $row2 =~ /^--/;

	chomp($row2);
	my ($company_cd, $department_set_cd, $department_cd, $user_cd, $department_main, $delete_flag1, $post_cd, $delete_flag2) = split(/\,/, $row2);

	if ( $department_cd eq $col1  ) {
	    print "                \<user-attach user-cd\=\"$user_cd\"\>\n";
	    print "                    \<term start-date\=\"$start_date\" end-date\=\"$end_date\" delete-flag\=\"false\" department-main=\"true\"\>\n";
	    print "                    \<\/term\>\n";
	    print "                \<\/user-attach\>\n";
	}
    }

    close $fh2;
    print "            \<\/department\>\n";

    $cnt++;
}
close $fh;

# フッタ出力
print "       \<\/department-set\>\n";
print "    \<\/company\>\n";
print "\<\/root\>\n";
