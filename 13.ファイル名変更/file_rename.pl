use strict;
use warnings;

# �J�����g�f�B���N�g�����I�[�v��
opendir my $dir, '.' or die $!;

# �t�H���_�̓��e�����ɓǂݍ���
while (my $old_name = readdir $dir) {
	print "$old_name\n";
	if (-f $old_name and $old_name =~ m/!\"\#$%&'\(\)\/\.\x{0020}/ ) {
		print "match:$old_name\n";
		$old_name =~ s/!\"\#$%&'\(\)\/\.\x{0020}/�I�h���������f�i�j�^�D\x{3000}/;
		my $new_name = $_;
		print "$new_name\n";
		rename $old_name, $new_name;
	}
}
closedir $dir;
