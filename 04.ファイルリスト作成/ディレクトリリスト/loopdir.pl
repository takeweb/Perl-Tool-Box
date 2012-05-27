use strict;
use warnings;

# カレントディレクトリをオープン
opendir my $dir, '.' or die $!;

# フォルダの内容を順に読み込み
while (my $name = readdir $dir) {

	if (-f $name) {
		my @info = stat $name;
		my $new_name = $info[0]
		my $updated = localtime $info[9];

		print $new_name;

		# 半角括弧を全角括弧へ変換
#		$new_name =~ s/\( \)/\（ \）/g;
#		print $new_name;

		#print "$name ( $info[7] byte ) $updated \n";
	}
}
closedir $dir;

#mkdir "new dir" or die "Cannot create dir: $!";
