use strict;
use warnings;

# 変数宣言
my ($emp_no) = @ARGV;		# 引数受け取り
my $year_moto = substr($emp_no, 2,3);
my $year_tail = substr($emp_no, 3,2);
my $nyusya_year = 0;

if ( $year_moto ge '100' ) {
	$nyusya_year = 2000 + $year_tail;
} else {
	$nyusya_year = 1900 + $year_tail;
}

#print "年の元：$year_moto\n";
#print "年の末尾：$year_tail\n";
print "入社年：$nyusya_year\n";
