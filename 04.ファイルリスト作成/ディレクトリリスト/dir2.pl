use strict;
use warnings;

my $dirname = '.';
opendir(DIR, $dirname) or die "$dirname: $!";
while (my $dir = readdir(DIR)) {
	next unless (-f $dir);
#	next unless ($dir =~ /\.html$/);
	next unless ($dir =~ /\.txt$/);
	print $dir, "\n";
	open(FILE, $dir) or die "dir: $!";
	my @file = <FILE>;
	close(FILE);
	foreach my $line (@file) {
#		$line =~ s/hyuki\@st\.rim\.or\.jp/hyuki@hyuki.com/g;
		$line =~ s/takeweb\@mac\.com/takeweb\@me\.com/g;
#		$line =~ s/takeweb\@me\.com/takeweb\@mac\.com/g;
	}
	open(NEWFILE, "> $dir") or die "$dir: $!";
	print NEWFILE @file;
	close(NEWFILE);
} 
closedir(DIR);

