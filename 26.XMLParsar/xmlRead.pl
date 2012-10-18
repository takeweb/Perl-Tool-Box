use strict;
use warnings;
use XML::Simple;
use Data::Dumper;

# �ϐ��錾
my ($path) = @ARGV;		# �����󂯎��
my $xml = XML::Simple->new;;

# XML�p�[�X
my $data = $xml->XMLin($path);

# ���ʏo��
#print Dumper($data);

my @rows = @{$data->{'component'}};
for $row (@rows) {
	my @cells = @{%{$row}->{Cell}};
	for my $cell(@cells) {
		
	}
}


foreach(keys(%{$data->{'component'}})) {
	print $_ . ", ";
	print $data->{'component'}->{'class'} . ", ";
	print $data->{'component'}->{'instance'} . "\n";
}

