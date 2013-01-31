use strict;
use warnings;
use File::Find;
use File::Basename 'fileparse';

# �w�b�_�s�o��
#print "�V�X�e��,�t�H���_,�t�@�C��,�g���q\n";
print "�t�H���_,�t�@�C��,�g���q\n";

# �����őΏۃf�B���N�g�����󂯎��Afind�ֈ����n��
find(\&wanted, $ARGV[0]);

# �ċA�ďo�֐�
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.pl$/;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/; # VBؽėp
#	return unless $path =~ /\.xls$|\.pdf$|\.doc$/; 			    # �h�L�������g�p
#print "$path\n";

	my ($file, $folder, $ext) = fileparse($path, qr/\..+$/);

	# �t�@�C����
	unless ( defined($file) ) {
	    $file = "";
	}

	# �t�H���_
	unless ( defined($folder) ) {
	    $folder = "";
	}
	
	# �g���q
	unless ( defined($ext) ) {
	    $ext = "";
	}

	print "$folder,";
	print "$file,";
	print "$ext\n";
}
