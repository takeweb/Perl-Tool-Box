use strict;
use warnings;

# �ϐ��錾
my ($emp_no) = @ARGV;		# �����󂯎��
my $year_moto = substr($emp_no, 2,3);
my $year_tail = substr($emp_no, 3,2);
my $nyusya_year = 0;

if ( $year_moto ge '100' ) {
	$nyusya_year = 2000 + $year_tail;
} else {
	$nyusya_year = 1900 + $year_tail;
}

#print "�N�̌��F$year_moto\n";
#print "�N�̖����F$year_tail\n";
print "���ДN�F$nyusya_year\n";
