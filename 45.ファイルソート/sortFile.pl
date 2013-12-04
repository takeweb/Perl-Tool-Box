use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;
use Text::Trim;

#�R�}���h���C�������̎��
my ($file_name) = @ARGV;

# �t�@�C���ǂݍ���
open my $fh, "< $file_name" or die $!;
my @list = <$fh>;
close $fh;

foreach my $line (sort @list) {
    next if $line =~ /^\n|^\#/;
    chomp $line;

    my $line_i = decode('utf-8', $line);
    my $line_o = encode('cp932', $line_i);

    my ($key, $value) = split(/=/, $line_o);
    if (defined $key) {
	print trim($key) . ',' . trim($value) . "\n";
    }
}

