#!perl

use strict;
use warnings;
use File::Path 'mkpath';

=pod ###################################################################
 定型ディレクトリ作成
=cut ###################################################################

# 定型ディレクトリ作成
while (my $line = <>) {
    next if $line =~ /^\r\n/;
    chomp $line;

	mkdir $line or die "Cannot create dir: $!";

}
