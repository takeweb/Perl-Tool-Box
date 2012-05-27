use strict;
use warnings;
use File::Find;

find(\&wanted, $ARGV[0]);

sub wanted {
	my $path = $File::Find::name;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/;
	return unless $path =~ /\.txt$/;
	return unless (-f $path);

#   $path ~= s/\//\\/g
	print "$path\n";
	open my $fl, '<', $path or die "Can't open file :$!";
	my @found = grep(/aaa|bbb|ccc/, <$fl>);
	print "@found";
	close $fl;
}
