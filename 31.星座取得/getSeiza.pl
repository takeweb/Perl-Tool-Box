#!perl

use strict;
use warnings;
use DateTime;

# 変数宣言
my ($year, $month, $day) = @ARGV;	# 引数受け取り
my $MEIJI  = DateTime -> new(year => 1868, month => 9, day => 8);
my $TAISHO = DateTime -> new(year => 1912, month => 7, day => 30);
my $SHOWA  = DateTime -> new(year => 1926, month => 12, day => 25);
my $HEISEI = DateTime -> new(year => 1989, month => 1, day => 8);

my $input_yyyymmdd = DateTime -> new(year => $year, month => $month, day => $day);
my $wareki = "";
my $wareki_year = 0;

if( (DateTime->compare($input_yyyymmdd, $MEIJI) == 0 ||
     DateTime->compare($input_yyyymmdd, $MEIJI) == 1 ) &&
     DateTime->compare($input_yyyymmdd, $TAISHO) == -1 ) {
    $wareki = "明治";
    $wareki_year = $year - 1867;
} elsif( (DateTime->compare($input_yyyymmdd, $TAISHO) == 0 ||
		  DateTime->compare($input_yyyymmdd, $TAISHO) == 1) && 
          DateTime->compare($input_yyyymmdd, $SHOWA) == -1 ) {
    $wareki = "大正";
    $wareki_year = $year - 1911;
} elsif( (DateTime->compare($input_yyyymmdd, $SHOWA) == 0 ||
		  DateTime->compare($input_yyyymmdd, $SHOWA) == 1) &&
		  DateTime->compare($input_yyyymmdd, $HEISEI) == -1 ) {
    $wareki = "昭和";
    $wareki_year = $year - 1925;
} elsif( DateTime->compare($input_yyyymmdd, $HEISEI) == 0 ||
		 DateTime->compare($input_yyyymmdd, $HEISEI) == 1 ){
    $wareki = "平成";
    $wareki_year = $year - 1988;
} else {
    $wareki = "不明"
}

if ( $wareki_year == 1  ) {
    $wareki_year = "元";
}

print "$wareki$wareki_year年$month月$day日\n";

