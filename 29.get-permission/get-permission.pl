use strict;
use warnings;

# 戻り値
my $rtn_str;

# コマンドライン引数を３文字ずつに分割
my @targets = $ARGV[0] =~ /.{3}/g;

# メイン
foreach my $target(@targets) {
	$rtn_str = $rtn_str . calc_to_oct($target);
}
# 結果出力
print "$rtn_str\n";

# 計算サブ(8進数へ変換)
sub calc_to_oct {
	# 戻り値	
	my $oct = 0;

	# 引数受け取り
	my $target = $_[0];

	# 引数を一文字ずつに分割
	my @permissions = $target =~ /.{1}/g;

	foreach my $permission(@permissions) {

		if ( $permission eq "r" ) {
			$oct += 4;			
		} elsif ( $permission eq "w" ) {
			$oct += 2;
		} elsif ( $permission eq "x" ) {
			$oct += 1;
		} else {
			$oct += 0;
		}
	}
	return $oct;
}
