use strict;
use warnings;

my $file = shift; # ファイル名を受け取る

open my $fh, "<", $file
    or die "Cannot open $file: $!";

while (my $line = <$fh>) {
    print "line $.: $line"; # 行番号を先頭に付加して出力
}

close $fh;

