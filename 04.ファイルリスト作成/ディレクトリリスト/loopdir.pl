use strict;
use warnings;

# �J�����g�f�B���N�g�����I�[�v��
opendir my $dir, '.' or die $!;

# �t�H���_�̓��e�����ɓǂݍ���
while (my $name = readdir $dir) {

	if (-f $name) {
		my @info = stat $name;
		my $new_name = $info[0]
		my $updated = localtime $info[9];

		print $new_name;

		# ���p���ʂ�S�p���ʂ֕ϊ�
#		$new_name =~ s/\( \)/\�i \�j/g;
#		print $new_name;

		#print "$name ( $info[7] byte ) $updated \n";
	}
}
closedir $dir;

#mkdir "new dir" or die "Cannot create dir: $!";
