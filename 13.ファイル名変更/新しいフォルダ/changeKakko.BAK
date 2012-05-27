
use strict;
use warnings;
use utf8;
use Encode;
#binmode STDIN,  ":encoding(cp932)";
#binmode STDOUT, ":encoding(cp932)";

# カレントディレクトリをオープン
opendir my $dir, '.' or die $!;

# フォルダの内容を順に読み込み
while (my $name = readdir $dir) {

	if (-f $name) {
print "$name\n";
       my $utf8 = decode("cp932", $name);
#print "$utf8\n";
		my $old_name = $name;
		my $new_name = "";

print "変換前：$name\n";

        # 半角括弧を全角括弧へ変換
#       $utf8 =~ s/\(\)/\（\）/g;
#       $name =~ s/\(\)/\（\）/g;
        $name =~ tr/\(\)/\（\）/;

       $new_name = encode("cp932", $utf8);

print "変換後：$new_name\n";

		rename $old_name, $name;
	}
}
closedir $dir;
