#!perl

use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

=pod ###################################################################
 ユーザ名暗号化(不可逆)
 $ARGV[0]⇒$userlist : 	暗号化対象のパスワード文字列の記述されたファイル
=cut ###################################################################

srand;

while (my $line = <>) {
    chomp $line;
    next if $line eq "";

#    $line = decode('UTF-8', $line);

    if ($line =~ /<user-name>(.*?)<\/user-name>/g) {
	my $userName = $1;
	my $angoUserName = &randcrypt($1);

	$line = "                <user-name>$angoUserName<\/user-name>";

    } elsif ($line =~ /<user-search-name>(.*?)<\/user-search-name>/g) {
	my $userName = $1;
	my $angoUserName = &randcrypt($1);

	$line = "                <user-search-name>$angoUserName<\/user-search-name>";
    }
#    $line = encode('UTF-8', $line);
    print "$line\n";
}

sub randcrypt {
    my($pass) = @_;
    my @salt_set = ('a'..'z','A'..'Z','0'..'9');
    my $idx1 = int(rand(61));
    my $idx2 = int(rand(61));
    my $idx3 = int(rand(61));
    my $idx4 = int(rand(61));
    my $idx5 = int(rand(61));
    my $idx6 = int(rand(61));
    my $salt = $salt_set[$idx1] . $salt_set[$idx2] . $salt_set[$idx3] .$salt_set[$idx4] . $salt_set[$idx5] .$salt_set[$idx6];
    return $salt;
}
