=head1 NAME

zenkigoToHankigo2.pl

=head1 SYONPSIS

zenkigoToHankigo2.pl FILE > outfile

=head1 DESCRIPTION

このスクリプトは全角英語、数字、記号、スペースを半角に変換します。

=cut

use strict;
use warnings;
use utf8;
use Encode qw/decode encode/;

#my $enq = 'cp932';
my $enq = 'UTF-8';

while(my $line = <>) {
	my $line = decode($enq, $line);
    $line =~ tr/Ａ-Ｚａ-ｚ０-９！”＃＄％＆’（）／．，\x{3000} /A-Za-z0-9!\"\#$%&'\(\)\/\.\,\x{0020}/;
    print encode($enq, $line);
}
