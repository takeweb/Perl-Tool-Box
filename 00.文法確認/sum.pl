use strict;
use warnings;

#コマンドライン引数の受取
my @nums = @ARGV;

#合計を求めるサブルーチンを呼出し
my $total = sum(@nums);

#合計の出力
print "合計:$total\n";

#合計を計算するサブルーチン
sub sum {
	#引数の受け取り
	my @nums = @_;

	#和の計算
	my $total = 0;
	foreach my $num (@nums) {
		$total += $num;
	}

	return $total;
}
