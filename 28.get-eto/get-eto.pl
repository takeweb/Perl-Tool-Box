use strict;
use warnings;

# コマンドライン引数受け取り
my $year = $ARGV[0];

# 干支定義　申が12で割り切れる
my @etos = ("申", "酉", "戌", "亥", "子", "丑", "寅", "卯", "辰", "巳", "午", "未");

# 12で剰余を計算
my $index = $year % 12;

# 結果出力
print "$etos[$index]\n";
