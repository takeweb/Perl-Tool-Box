use strict;
use warnings;

# �J�����g�f�B���N�g�����I�[�v��
opendir my $dir, '.' or die $!;

# �t�H���_�̓��e�����ɓǂݍ���
while (my $name = readdir $dir) {

	if (-f $name and $name =~ m/\.java$/ ) {
		my @info = stat $name;
		my $updated = localtime $info[9];
		print "perl nl2lf.pl < $name > $name"."_new\n";
	}
}
closedir $dir;
