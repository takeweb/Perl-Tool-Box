use strict;
use warnings;
use Time::Local 'timelocal';

# ヘッダー情報取得
my @headers;
open(FILE, "./header.sh") or die "header.sh: $!";
my @headers = <FILE>;
close (FILE);

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;

# ディレクトリ再帰処理呼出
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

    # ヘッダー行出力
    foreach my $header (reverse @headers) {
        $header =~ s/yyyy\/mm\/dd/$year\/$mon\/$mday/g;
        unshift @file, $header
    }

	foreach my $line (@file) {
        if ($line =~ /utlsend/) {
            @hulft_line = split(/ /, $line);
        }

        # 不要行コメントアウト
        $line =~ s/^\/home\/db_user*/\#\/home\/db_user/g; # /home/db_userに該当する行をコメントアウト
        $line =~ s/^export*/\#export/g;                   # exportに該当する行をコメントアウト
    }

    # 新規行を挿入
    my $hulft_id = pop @hulft_line;
    $newline =~ s/HULFT_ID/$hulft_id/g;
    push @file, $newline;

    # ファイルへ書き込み
	open(NEWFILE, "> $filename") or die "$filename: $!";
	print NEWFILE @file;
	close(NEWFILE);
}
