use strict;
use warnings;

# �t�@�C����ǂݎ���p���[�h�ŊJ��
open my $fl, '< data.txt' or die $!;

# �t�@�C���̓��e��擪�s���珇�ɓǂݍ���
while (my $row = <$fl>) {
	chomp $row;
	my @data = split /\t/, $row;
	print "$data[1] ($data[2] $data[3]) \n";
}
close $fl;

