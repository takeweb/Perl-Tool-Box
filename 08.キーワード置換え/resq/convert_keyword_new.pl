use strict;
use warnings;
use Time::Local 'timelocal';
use File::Basename 'fileparse';

# ヘッダー情報取得
my @headers;
open(FILE, "./header.txt") or die "header.txt: $!";
@headers = <FILE>;
close (FILE);

# コメント情報取得
my @comments;
open(FILE, "./comment.txt") or die "comment.txt: $!";
@comments = <FILE>;
close (FILE);

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;

# ディレクトリ再帰処理呼出
&traverse($ARGV[0]);

#########################
## ディレクトリ探査関数
#########################
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

#########################
## ファイル処理関数
#########################
sub do_file {

	my $filename = shift;
	return unless ($filename =~ /\.sh$/);       # シェル以外は対象外
	return if ($filename =~ /S_CRM_ORA.sh$/);   # S_CRM_ORA.shは修正対象外

print $filename, "\n";

    my @ins;
    my $cnt;
	open(FILE, $filename) or die "$filename: $!";
	my @file = <FILE>;
	close (FILE);

    $cnt = 0;
#   foreach my $line (@file) {
    foreach my $i(0..$#file) {

        my $line = $file[$i];
#       print "$line\n";

        if ($line =~ /\#--------------------------------------------------\#/) {
            $cnt += 1;
            print "matched:$line--$cnt\n";
        }

        if ($cnt == 2) {
            print "cnt:$cnt\n";

            # ヘッダー行出力
            foreach my $comment (@comments) {
                $comment =~ s/yyyy\.mm\.dd/$year\.$mon\/$mday/g;
#               print "comment:$comment\n";
        #       unshift @file, $comment;
                push(@ins, $comment);
            }

#           print "comment:$comment\n";
#           print "ins:@ins\n";
            my @removed = splice(@file, $i, 0, @ins);
#           print "remove:@removed";
            $cnt += 1;
        }

        # 不要行コメントアウト
        $line =~ s/^\/home\/db_user/\#\/home\/db_user/g;    # /home/db_userに該当する行をコメントアウト
        $line =~ s/^\.\ \/home/\#\.\ \/home/g;              # . /homeに該当する行をコメントアウト
        $line =~ s/^\export/\#export/g;                     # exportに該当する行をコメントアウト
        $line =~ s/^HOM_PATH/\#HOM_PATH/g;                  # HOM_PATHに該当する行をコメントアウト
        $line =~ s/^JCL_PATH/\#JCL_PATH/g;                  # JCL_PATHに該当する行をコメントアウト
        $line =~ s/^DATA_PATH/\#DATA_PATH/g;                # DATA_PATHに該当する行をコメントアウト
        $line =~ s/^SQL_PATH/\#SQL_PATH/g;                  # SQL_PATHに該当する行をコメントアウト
        $line =~ s/^LOG_PATH/\#LOG_PATH/g;                  # LOG_PATHに該当する行をコメントアウト
    }

    # 新規行を挿入
#   my $hulft_id = pop @hulft_line;
#   push @file, $newline;

    # ファイルへ書き込み
	open(NEWFILE, "> $filename") or die "$filename: $!";
	print NEWFILE @file;
	close(NEWFILE);
}
