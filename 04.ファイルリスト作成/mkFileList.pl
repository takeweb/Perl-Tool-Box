use strict;
use warnings;
use File::Find;

# �w�b�_�s�o��
print "�V�X�e��,�t�H���_,�t�@�C��,�g���q\n";

# �����őΏۃf�B���N�g�����󂯎��Afind�ֈ����n��
find(\&wanted, $ARGV[0]);

# �ċA�ďo�֐�
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.pl$/;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/; # VBؽėp
	return unless $path =~ /\.xls$|\.pdf$|\.doc$/; 						# �h�L�������g�p
#   print "$path\n";

	my @path = split('/', $path);

	my $file = pop(@path);
	my $folder = pop(@path);
	my $system = pop(@path);
	
	# �g���q
	$file =~ m|(.*?)(\.\S*)|;
    my $ext = $2;

	print "$system,";
	print "$folder,";
	print "$file,";
	print "$ext\n";
}
