#!perl

use strict;
use warnings;

=pod ###################################################################
 �p�X���[�h�Í���(�s�t)
 $ARGV[0]��$userlist : 	�Í����Ώۂ̃p�X���[�h������̋L�q���ꂽ�t�@�C��
=cut ###################################################################

# �ϐ��錾
my $angoPassword;   # �Í�����p�X���[�h
my $userid;

# �R�}���h���C�������̎��
my ($userlist) = @ARGV;

srand;

# �������t�@�C���̏ꍇ
if ( -f $userlist ) {
    while ($userid = <>) {
	chomp $userid;
	next if $userid eq "";

#       my $userid = "11" . $userlist;
#	$userid = $userlist;
	$angoPassword = "";
	$angoPassword = &randcrypt($userid); 
	printf "%s,%s\n", $userid, $angoPassword;
#       print $userid . "\," . $angoPassword. "\n";
    }
} else {
    $userid = $userlist;
    $angoPassword = &randcrypt($userid); 
    print "�Í����p�X���[�h�F". $angoPassword . "\n";
}

#&hantei($password, $angoPassword);

sub randcrypt {
    my($pass) = @_;
    my @salt_set = ('a'..'z','A'..'Z','0'..'9','.','/');
    my $idx1 = int(rand(63));
    my $idx2 = int(rand(63));
    my $salt = $salt_set[$idx1] . $salt_set[$idx2];
    return crypt($pass, $salt);
}

sub hantei {
    my($password, $angoPassword) = @_;
    my $angoPassword2 = crypt($password, $angoPassword);

    if ( $angoPassword eq $angoPassword2  ) {
	print "�p�X���[�h��v\n";
	print "�Í����p�X���[�h�F". $angoPassword2 . "\n";
    } else {
	print "�p�X���[�h�s��v\n";
    }
}
