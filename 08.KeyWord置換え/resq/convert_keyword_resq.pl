use strict;
use warnings;
use Time::Local 'timelocal';

# ヘッダー情報取得
my @headers;
open(FILE, "./header.txt") or die "header.txt: $!";
@headers = <FILE>;
close (FILE);

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;

# ディレクトリ再帰処理呼出
&traverse($ARGV[0]);

sub traverse {
	my $dirname = shift;
	my $delim = '/';
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
	return unless ($filename =~ /\.sh$/);
	print $filename, "\n";

#   my $newline = "utlsend -f HULFT_ID\n";
#   my @hulft_line;
    my $header;
    my @ins;
    my $cnt;

	open(FILE, $filename) or die "$filename: $!";
	my @file = <FILE>;
	close (FILE);

    # ヘッダー行出力
    foreach $header (reverse @headers) {
        $header =~ s/yyyy\.mm\.dd/$year\.$mon\.$mday/g;
        print $header;
    }

    $cnt = 0;
#	foreach my $line (@file) {
	foreach my $i(0..$#file) {
        my $line = $file[$i];
        if ($line =~ /\#--------------------------------------------------\#/) {
           print "matched:$line\n";
#           unshift @file, $header;
            $cnt += 1;
        }
#
#       if ($cnt == 2) {
#           push(@ins, $header);
#           my @removed = splice(@file, 5, 0, @ins);
#       }

#       if ($line =~ /utlsend/) {
#           @hulft_line = split(/ /, $line);
#       }

        # 不要行コメントアウト
#       $line =~ s/^\/home\/db_user/\#\/home\/db_user/g;    # /home/db_userに該当する行をコメントアウト
#       $line =~ s/^\.\ \/home/\#\.\ \/home/g;              # /home/db_userに該当する行をコメントアウト
        $line =~ s/^\export/\#export/g;                     # exportに該当する行をコメントアウト
        $line =~ s/^HOM_PATH/\#HOM_PATH/g;                  # HOM_PATHに該当する行をコメントアウト
        $line =~ s/^JCL_PATH/\#JCL_PATH/g;                  # JCL_PATHに該当する行をコメントアウト
        $line =~ s/^DATA_PATH/\#DATA_PATH/g;                # DATA_PATHに該当する行をコメントアウト
        $line =~ s/^SQL_PATH/\#SQL_PATH/g;                  # SQL_PATHに該当する行をコメントアウト
        $line =~ s/^LOG_PATH/\#LOG_PATH/g;                  # LOG_PATHに該当する行をコメントアウト
    }

    # 新規行を挿入
#   my $hulft_id = pop @hulft_line;
#   $newline =~ s/HULFT_ID/$hulft_id/g;
#   push @file, $newline;

    # ファイルへ書き込み
	open(NEWFILE, "> $filename") or die "$filename: $!";
	print NEWFILE @file;
	close(NEWFILE);
}
