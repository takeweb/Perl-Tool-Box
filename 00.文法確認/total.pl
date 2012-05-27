use strict;
use warnings;

# コマンドライン引数を受け取る
my @nums = @ARGV;

# 和の計算
my $total = 0;
foreach my $num (@nums) {
	$total += $num;
}

# 計算結果の出力
print "Total:$total\n";

