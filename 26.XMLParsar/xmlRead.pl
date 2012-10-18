use strict;
use warnings;
use XML::Simple;
use Data::Dumper;

# 変数宣言
my ($path) = @ARGV;		# 引数受け取り
my $xml = XML::Simple->new;;

# XMLパース
my $data = $xml->XMLin($path);

# 結果出力
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

