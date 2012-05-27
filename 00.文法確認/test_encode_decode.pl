# 文法チェック
use strict;
use warnings;
use utf8;
use Encode;

my $str = "処理終了";
#print "変換前：$str\n";
print encode('utf-8', $str) . "\n";

my $utf8 = decode('cp932', $str);
print "decode後：$utf8\n";

my $new_name = encode('cp932', $utf8);
print "encode語：$new_name\n";
