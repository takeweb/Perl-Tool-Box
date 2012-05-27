use strict;
use warnings;

# �w�b�_�[���擾
my @headers;
open(FILE, "./header.sh") or die "header.sh: $!";
my @headers = <FILE>;
close (FILE);

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

    my $newline = "utlsend -f HULFT_ID\n";
    my @hulft_line;

	my $filename = shift;
	return unless ($filename =~ /\.sh$/);

print $filename, "\n";

	open(FILE, $filename) or die "$filename: $!";
	my @file = <FILE>;
	close (FILE);

    # �w�b�_�[�s�o��
    foreach my $header (reverse @headers) {
        unshift @file, $header
    }

	foreach my $line (@file) {
        if ($line =~ /utlsend/) {
            @hulft_line = split(/ /, $line);
        }

        # �s�v�s�R�����g�A�E�g
        $line =~ s/^\/home\/db_user*/\#\/home\/db_user/g; # /home/db_user�ɊY������s���R�����g�A�E�g
        $line =~ s/^export*/\#export/g;                   # export�ɊY������s���R�����g�A�E�g
    }

    # �V�K�s��}��
    my $hulft_id = pop @hulft_line;
    $newline =~ s/HULFT_ID/$hulft_id/g;
    push @file, $newline;

    # �t�@�C���֏�������
	open(NEWFILE, "> $filename") or die "$filename: $!";
	print NEWFILE @file;
	close(NEWFILE);
}
