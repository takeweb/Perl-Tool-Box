use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

$\ = "\n";

#コマンドライン引数の受取
my ($sub_dir) = @ARGV;
$sub_dir = decode('cp932', $sub_dir);

my $root = "D:/ooishi/tmp/";
my $path = "";

# ファイルを読み取り専用モードで開く
open my $fh1, '< list.txt' or die $!;
my @list = <$fh1>;
close $fh1;

# ファイルの内容を先頭行から順に読み込み
#while (my $filename = <$fh1>) {
foreach my $filename (@list) {
    chomp $filename;

    $filename = decode('UTF-8', $filename);

    print $filename;

    $path = "";
    $path = $root . $sub_dir . '/' . $filename;
    $path = encode('cp932', $path);
    print $path;

    open my $fh2, '< $path' or die $!;
    while (my $row = <$fh2>) {
	print $row;
    }

    close $fh2;
}
#close $fh1;

