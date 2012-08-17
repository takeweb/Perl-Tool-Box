use strict;
use warnings;
use Time::Local 'timelocal';
use File::Basename 'fileparse';

# ヘッダー情報取得
my @headers;
open(FILE, "./header.txt") or die "header.txt: $!";
@headers = <FILE>;
close (FILE);

# 現在時刻取得
my ($sec, $min, $hour, $mday, $mon, $year) = localtime;
$mon += 1;
$year += 1900;
$mon = sprintf("%02d", $mon);
$mday = sprintf("%02d", $mday);

# ディレクトリ再帰処理呼出
&traverse($ARGV[0]);

#########################
## ディレクトリ探査関数
#########################
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
    print "DIR\n";
    closedir(DIR);
}

#########################
## ファイル処理関数
#########################
sub do_file {

    my $filename = shift;
    return unless ($filename =~ /\.sh$|\.SH$/); # シェル以外は対象外
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

        if ($line =~ /\#-+\#/) {
            $cnt += 1;
            print "matched:$line--$cnt\n";
        }

        if ($cnt == 2) {
            print "cnt:$cnt\n";

            # ヘッダー行出力
            foreach my $header (@headers) {
                $header =~ s/yyyy\.mm\.dd/$year\.$mon\.$mday/g;
                print "header:$header\n";
                push(@ins, $header);
            }

#print "ins[0]:$ins[0]";
#print "ins[1]:$ins[1]";
#print "ins[2]:$ins[2]";
#print "ins[3]:$ins[3]";
#print "ins[4]:$ins[4]";
#print "ins[5]:$ins[5]";

            my @ins1 = ($ins[0], $ins[1]);
            my @ins2 = ($ins[3], $ins[4], $ins[5]);
            print "ins:@ins\n";
            print "ins1:@ins1\n";
            print "ins2:@ins2\n";
            my @removed1 = splice(@file, $i,   0, @ins1);
#           print "before_file:@file\n";
            my @removed2 = splice(@file, $i+3, 0, @ins2);
#           print "after_file:@file\n";
#           print "removed1:@removed1\n";
#           print "removed2:@removed2\n";
            $cnt += 1;
        }

        # 不要行コメントアウト
        $line =~ s/^\/home\/db_user/\#\/home\/db_user/g;    # /home/db_userに該当する行をコメントアウト
        $line =~ s/^\.\ \/home/\#\.\ \/home/g;              # . /homeに該当する行をコメントアウト
        $line =~ s/^\export/\#export/g;                     # exportに該当する行をコメントアウト
        $line =~ s/^HOM_PATH/\#HOM_PATH/g;                  # HOM_PATHに該当する行をコメントアウト
        $line =~ s/^HOM_PASS/\#HOM_PASS/g;                  # HOM_PASSに該当する行をコメントアウト
        $line =~ s/^JCL_PATH/\#JCL_PATH/g;                  # JCL_PATHに該当する行をコメントアウト
        $line =~ s/^JCL_PASS/\#JCL_PASS/g;                  # JCL_PASSに該当する行をコメントアウト
        $line =~ s/^DATA_PATH/\#DATA_PATH/g;                # DATA_PATHに該当する行をコメントアウト
        $line =~ s/^DATA_PASS/\#DATA_PASS/g;                # DATA_PASSに該当する行をコメントアウト
        $line =~ s/^SQL_PATH/\#SQL_PATH/g;                  # SQL_PATHに該当する行をコメントアウト
        $line =~ s/^SQL_PASS/\#SQL_PASS/g;                  # SQL_PASSに該当する行をコメントアウト
        $line =~ s/^LOG_PATH/\#LOG_PATH/g;                  # LOG_PATHに該当する行をコメントアウト
        $line =~ s/^LOG_PASS/\#LOG_PASS/g;                  # LOG_PATHに該当する行をコメントアウト
        $line =~ s/^HUL_PASS/\#HUL_PASS/g;                  # HUL_PASSに該当する行をコメントアウト
        $line =~ s/^QAC_JCL_PASS/\#QAC_JCL_PASS/g;          # QAC_JCL_PASSに該当する行をコメントアウト
        $line =~ s/^ORA_PASS/\#ORA_PASS/g;                  # ORA_PASSに該当する行をコメントアウト
        $line =~ s/^CTL_PATH/\#CTL_PATH/g;                  # CTL_PATHに該当する行をコメントアウト

        if ($cnt != 3) {
            $file[$i] = $line;
        }
    }

    # 新規行を挿入
#   my $hulft_id = pop @hulft_line;
#   push @file, $newline;

    # ファイルへ書き込み
	open(NEWFILE, "> $filename") or die "$filename: $!";
	print NEWFILE @file;
	close(NEWFILE);
}
