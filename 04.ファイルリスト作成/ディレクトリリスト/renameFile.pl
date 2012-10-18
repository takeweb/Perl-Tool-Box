use strict;
use warnings;

# ファイル名変更
for (glob("*.java_new")) {
	my $old_name = $_;
	s/.java_new/.java/i;
	my $new_name = $_;
	print $new_name\n;
	rename $old_name, $new_name;
}
