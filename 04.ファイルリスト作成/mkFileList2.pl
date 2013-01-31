use strict;
use warnings;
use File::Find;
use File::Basename 'fileparse';

# ヘッダ行出力
#print "システム,フォルダ,ファイル,拡張子\n";
print "フォルダ,ファイル,拡張子\n";

# 引数で対象ディレクトリを受け取り、findへ引き渡し
find(\&wanted, $ARGV[0]);

# 再帰呼出関数
sub wanted{
	my $path = $File::Find::name;
#	return unless $path =~ /\.pl$/;
#	return unless $path =~ /\.frm$|\.frx$|\.bas$|\.vbp$|\.vbw$|\.cls$/; # VBﾘｽﾄ用
#	return unless $path =~ /\.xls$|\.pdf$|\.doc$/; 			    # ドキュメント用
#print "$path\n";

	my ($file, $folder, $ext) = fileparse($path, qr/\..+$/);

	# ファイル名
	unless ( defined($file) ) {
	    $file = "";
	}

	# フォルダ
	unless ( defined($folder) ) {
	    $folder = "";
	}
	
	# 拡張子
	unless ( defined($ext) ) {
	    $ext = "";
	}

	print "$folder,";
	print "$file,";
	print "$ext\n";
}
