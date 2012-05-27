use strict;
use warnings;

&traverse($ARGV[0]);

sub traverse {
	my $dirname = shift;
	my $delim = "\\";
	opendir(DIR, $dirname) or die "$dirname: $!";
	foreach my $entry (readdir(DIR)) {
		next if ($entry eq '.');
		next if ($entry eq '..');
		if ($dirname =~ /[\/\\]$/) {
			$delim = '';
		}
		my $filename = "$dirname$delim$entry";
		if (-d $filename) {
			&traverse($filename);
		} else {
			&do_file($filename);
		}
	}
	closedir(DIR);
}

sub do_file {

	my $filename = shift;
	return unless ($filename =~ /\.ini$/);

	open(FILE, $filename) or die "$filename: $!";
	while (my $line = <FILE>) {
        if ($line =~ /RICOH_ORA\.WORLD|RICOH_ORA2\.WORLD|O9I_DEV\.WORLD/) {
#           chomp($line);
            print $filename, "\t";
            print "line $.: $line"; # s”Ô†‚ğæ“ª‚É•t‰Á‚µ‚Äo—Í
        }
    }
    close (FILE);
}
