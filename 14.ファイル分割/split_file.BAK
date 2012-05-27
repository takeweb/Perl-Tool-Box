#!perl

use strict;
use warnings;

########################################################
# ファイル分割
#    第１引数:  元ファイル名
#    第２引数:  分割行数 省略時は65535行ごとに分割
#    出力:      分割されたファイル1～・・・
########################################################

# 第2引数 省略時は65535行ごとに分割
$ARGV[1] = 65535 unless $ARGV[1];

# 引数受け取り
#my ($output, $max_row) = shift;
my $max_row = pop @ARGV;
my $output = $ARGV[0];

my $file_cnt = 1;
#my $file_cnt_out = '01';
my $row_cnt;
my $ext = '.csv';

#$output =~ s/(\.\w+$)/$file_cnt$1/;
$output =~ s/(\.\w+$)/$file_cnt$ext/;
open OUTPUT, '>',  $output or die qq/can't create file:$!/;

while (my $line = <>) {
    next if $line =~ /^\n/;
#   next unless $line =~ /^2011\/05\/18 |^2011\/05\/19 /;

    chomp $line;

    # カラム分割
    my ($col1, $col2, $col3) = split(/\s+/, $line);
    print OUTPUT $col1 . ',' . $col2 . ',' . $col3 ."\n";
#   print OUTPUT $line ."\n";

    $row_cnt ++;

    # 出力先ファイル切替
    if ($row_cnt >= $max_row) {
        $row_cnt = 0;
        close OUTPUT;
        $output =~ m/($file_cnt)\./;
        $file_cnt ++;
#       $file_cnt_out = sprintf("%01d", $file_cnt);
        $output =~ s/$1(\.\w+$)/$file_cnt$1/;
        open OUTPUT, '>', $output or die qq/can't create file:$!/;
    }
}
