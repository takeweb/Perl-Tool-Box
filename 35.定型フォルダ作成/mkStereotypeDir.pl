#!perl

use strict;
use warnings;
use File::Path 'mkpath';

=pod ###################################################################
 ��^�f�B���N�g���쐬
=cut ###################################################################

# ��^�f�B���N�g���쐬
while (my $line = <>) {
    next if $line =~ /^\r\n/;
    chomp $line;

	mkdir $line or die "Cannot create dir: $!";

}
