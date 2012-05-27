use strict;
use warnings;

# ファイルを読み取り専用モードで開く
open my $fl, '< data.txt' or die $!;

# ファイルの内容を先頭行から順に読み込み
while (my $row = <$fl>) {
	chomp $row;
	my @data = split /\t/, $row;
	print "$data[1] ($data[2] $data[3]) \n";
}
close $fl;

