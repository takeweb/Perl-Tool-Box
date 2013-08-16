use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

## 実行例
#  perl marge.pl 2013-07-19>result3.txt
##

$\ = "\n";

#my $root = "D:/ooishi/tmp/";
my $root = "D:\\ooishi\\Dropbox\\GitHub\\Perl-Tool-Box\\42.ファイル結合\\data\\";
#my $root = "X:/WEBチーム作成物/00.管理資料/02_内部進捗資料/各自報告メモ/";
#my $root = "\\\\172.80.24.21\\janis\\販売管理\\WEBチーム作成物\\00.管理資料\\02_内部進捗資料\\各自報告メモ\\";

#コマンドライン引数の受取
my ($sub_dir) = @ARGV;

# ファイル名リスト読み込み
open my $fh1, '< list.txt' or die $!;
my @list = <$fh1>;
close $fh1;

my $delim = "--xxxx------------------------------------------------------------------------------------------------";

my $title = $sub_dir . "報告分";
$title = encode('cp932', $title);
print $title;

foreach my $filename (@list) {
    chomp $filename;

    # 内部文字列に変換(ファイルリストの文字コード)
    my $filename_i = decode('utf-8', $filename);

    # バイト文字列に変換(OSの文字コード)
    my $filename_b = encode('cp932', $filename_i);
    my $root_b = encode('cp932', $root);

    my $path = $root_b . $sub_dir . '\\' . $filename_b;

    open my $fh, '<', $path
	or die qq{Can't open file "$path": $!};

    # ヘッダ出力
    my $delim_tmp = $delim;
    $delim_tmp =~ s/xxxx/$filename_b/;
    print "";
    print "";
    print $delim_tmp;

    # 報告内容出力
    while (my $line = <$fh>) {
	chomp $line;
	print $line;
    }
    close $fh;
}
