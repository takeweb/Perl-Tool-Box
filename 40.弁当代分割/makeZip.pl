use strict;
use warnings;
use utf8;
use Archive::Zip;

my $zip_file = "archive.zip";

my $zip = Archive::Zip->new();

$zip->addFile("\\\172.80.24.21\\janis\\�̔��Ǘ�\\10_�ŐV�h�L�������g\\21_DB�֘A\\02_�e�[�u����`\\01_�}�X�^�n\\�e�[�u����`��_KRIM001_�����i�݌Ƀ}�X�^\.xlsx");
$zip->addFile("\\\172.80.24.21\\janis\\�̔��Ǘ�\\10_�ŐV�h�L�������g\\21_DB�֘A\\02_�e�[�u����`\\01_�}�X�^�n\\�e�[�u����`��_KRJM001_�Ǝ�}�X�^\.xlsx");
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
