use strict;
use warnings;
use File::Find;

# ヘッダ行出力
print "システム,フォルダ,ファイル,拡張子\n";

# 引数で対象ディレクトリを受け取り、findへ引き渡し
find(\&wanted, $ARGV[0]);

# 再帰呼出関数
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.pl$/;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/; # VBﾘｽﾄ用
	return unless $path =~ /\.xls$|\.pdf$|\.doc$/; 						# ドキュメント用
#   print "$path\n";

	my @path = split('/', $path);

	my $file = pop(@path);
	my $folder = pop(@path);
	my $system = pop(@path);
	
	# 拡張子
	$file =~ m|(.*?)(\.\S*)|;
    my $ext = $2;

	print "$system,";
	print "$folder,";
	print "$file,";
	print "$ext\n";
}
