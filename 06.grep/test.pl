use strict;
use warnings;

my $file = shift; # �t�@�C�������󂯎��

open my $fh, "<", $file
    or die "Cannot open $file: $!";

while (my $line = <$fh>) {
    print "line $.: $line"; # �s�ԍ���擪�ɕt�����ďo��
}

close $fh;

