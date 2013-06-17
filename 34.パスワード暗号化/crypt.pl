#!perl

use strict;
use warnings;

=pod ###################################################################
 パスワード暗号化(不可逆)
 $ARGV[0]⇒$userlist : 	暗号化対象のパスワード文字列の記述されたファイル
=cut ###################################################################

# 変数宣言
my $angoPassword;   # 暗号化後パスワード
my $userid;

# コマンドライン引数の受取
my ($userlist) = @ARGV;

srand;

# 引数がファイルの場合
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
    print "暗号化パスワード：". $angoPassword . "\n";
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
	print "パスワード一致\n";
	print "暗号化パスワード：". $angoPassword2 . "\n";
    } else {
	print "パスワード不一致\n";
    }
}
