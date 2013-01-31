use strict;
use warnings;
use utf8;

#######################################################
# IM-共通マスタ組織XML文作成
#    第１引数:  組織データファイル名
#    第２引数： 組織・役職データファイル名
#    第３引数： 会社コード
#    第４引数： 親組織コード
#    標準出力： 出力ファイルに結果をリダイレクト
########################################################

my $file_so = $ARGV[0];
my $file_soyaku = $ARGV[1];
my $company_cd = "$ARGV[2]";
my $parent_cd = $ARGV[3];
my $offset = 0;
my $sort_key = 0;
my $start_date = "1900-01-01";
my $end_date = "3000-01-01";
my @department_cds;
my $index = 0;
$\ = "\n";

# ヘッダ出力
print "\<\?xml version\=\"1.0\" encoding\=\"UTF-8\"\?\>";
print "\<root xmlns\=\"http\:\/\/intra-mart\.co\.jp\/system\/master\/company\"\>";
print "    \<company company-cd=\"$company_cd\"\>";
print "        \<department-set department-set-cd=\"$company_cd\"\>";

# 組織リストを読み込み
open my $fh, '<', $file_so or die qq/Can't open file "$file_so" : $!/;

while (my $row = <$fh>) {
    next if $row =~ /^\n/;
    next if $row =~ /^--/;

    $sort_key = $offset + $index;

    chomp($row);
    # 組織コード、組織名称の取り出し　タブ区切り
    my ($department_cd1, $department_name) = split(/\s+/, $row);
    $department_cds[$index] = $department_cd1;

    print "            \<department department-cd\=\"$department_cd1\" sort-key\=\"$sort_key\"\>";
    print "                \<term start-date\=\"$start_date\" end-date\=\"$end_date\" delete-flag\=\"false\"\>";
    print "                    \<locale locale-id\=\"ja\"\>";
    print "                        \<department-name\>$department_name\<\/department-name\>";
    print "                        \<department-short-name\>$department_name\<\/department-short-name\>";
    print "                        \<department-search-name\>\<\/department-search-name\>";
    print "                        \<country-cd\>\<\/country-cd\>";
    print "                        \<zip-code\>\<\/zip-code\>";
    print "                        \<address1\>\<\/address1\>";
    print "                        \<address2\>\<\/address2\>";
    print "                        \<address3\>\<\/address3\>";
    print "                        \<telephone-number\>\<\/telephone-number\>";
    print "                        \<extension-number\>\<\/extension-number\>";
    print "                        \<fax-number\>\<\/fax-number\>";
    print "                        \<extension-fax-number\>\<\/extension-fax-number\>";
    print "                        \<email-address1\>\<\/email-address1\>";
    print "                        \<email-address2\>\<\/email-address2\>";
    print "                        \<url\>\<\/url\>";
    print "                        \<notes\>\<\/notes\>";
    print "                    \<\/locale\>";
    print "                \<\/term\>";

    # 組織リストを読み込み
    open my $fh2, '<', $file_soyaku or die qq/Can't open file $file_soyaku : $!/;

    while (my $row2 = <$fh2>) {
	
	next if $row2 =~ /^\n/;
	next if $row2 =~ /^--/;

	chomp($row2);
	my ($company_cd, $department_set_cd, $department_cd2, $user_cd, $department_main, $delete_flag1, $post_cd, $delete_flag2) = split(/\,/, $row2);

	if ( $department_cd1 eq $department_cd2 ) {
	    print "                \<user-attach user-cd\=\"$user_cd\"\>";
	    print "                    \<term start-date\=\"$start_date\" end-date\=\"$end_date\" delete-flag\=\"false\" department-main=\"true\"\>";
	    print "                    \<\/term\>";
	    print "                \<\/user-attach\>";
	}
    }

    close $fh2;
    print "            \<\/department\>";

    $index++;
}
close $fh;

print "            \<inclusion\>";
print "                \<term start-date=\"$start_date\" end-date=\"$end_date\" delete-flag=\"false\"\>";


foreach my $department_cd ( @department_cds  ) {
    print "                    \<relation parent-department-cd=\"$parent_cd\" department-cd=\"$department_cd\"";
    print "                    \<\/relation\>";
}

print "                \<\/term\>";
print "            \<\/inclusion\>";


# フッタ出力
print "       \<\/department-set\>";
print "    \<\/company\>";
print "\<\/root\>";
