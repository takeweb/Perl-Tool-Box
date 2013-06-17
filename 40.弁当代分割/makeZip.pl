use strict;
use warnings;
use utf8;
use Archive::Zip;

my $zip_file = "archive.zip";

my $zip = Archive::Zip->new();

$zip->addFile("\\\172.80.24.21\\janis\\販売管理\\10_最新ドキュメント\\21_DB関連\\02_テーブル定義\\01_マスタ系\\テーブル定義書_KRIM001_貯蔵品在庫マスタ\.xlsx");
$zip->addFile("\\\172.80.24.21\\janis\\販売管理\\10_最新ドキュメント\\21_DB関連\\02_テーブル定義\\01_マスタ系\\テーブル定義書_KRJM001_家主マスタ\.xlsx");
$zip->writeToFileNamed($zip_file);

#while (my $line = <>) {
#    next if $line =~ /^\n/;
#    
#    chomp $line;
#    
#    if ($line =~ /INSERT \[dbo\]\.\[SD/) {
#	print "$line\n";
#    }
#}
