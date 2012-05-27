use strict;
use warnings;

# ファイルフルパス
#my $file_old = '/var/log/aaa.txt';
#my $file_old = 'C:\\USERi\\BMEDI_SYSOUTi\\BM_D_TANi\\BM_D_TAN.exe xxxx';
my $file_old = 'C:\\USERi\\BMEDI_SYSOUTi\\BM_D_TANi\\BM_D_TAN.pl xxxx';

# ファイルフルパスからファイル名、拡張子を分離
#$file_old =~ m|(^.*/)?(.*?)(\.[^\.]+)|;
$file_old =~ m|(^.*\\)?(.*?)(\.\S*)(\s?\S*)|;   #ディレクトリ、ファイル名(拡張子無し)、拡張子、パラメータ
#$file_old =~ m|(^.*\\)?(.*?\.\S*)(\s?\S*)|;    #ディレクトリ、ファイル名(拡張子付き)、パラメータ

my $dir_name = $1;
my $base_name = $2;
my $ext = $3;
#my $param = $3;
my $param = $4;

print "dir_name = $dir_name\n";
print "base_name = $base_name\n";
print "ext = $ext\n";
print "param = $param\n";
