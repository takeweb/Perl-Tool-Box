use strict;
use warnings;

# カレントディレクトリをオープン
opendir my $dir, '.' or die $!;

# フォルダの内容を順に読み込み
while (my $old_name = readdir $dir) {
	print "$old_name\n";
	if (-f $old_name and $old_name =~ m/!\"\#$%&'\(\)\/\.\x{0020}/ ) {
		print "match:$old_name\n";
		$old_name =~ s/!\"\#$%&'\(\)\/\.\x{0020}/！”＃＄％＆’（）／．\x{3000}/;
		my $new_name = $_;
		print "$new_name\n";
		rename $old_name, $new_name;
	}
}
closedir $dir;
