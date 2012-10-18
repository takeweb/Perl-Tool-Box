use strict;
use warnings;

# カレントディレクトリをオープン
opendir my $dir, '.' or die $!;

# フォルダの内容を順に読み込み
while (my $name = readdir $dir) {

	if (-f $name and $name =~ m/\.java$/ ) {
		my @info = stat $name;
		my $updated = localtime $info[9];
		print "perl nl2lf.pl < $name > $name"."_new\n";
	}
}
closedir $dir;
