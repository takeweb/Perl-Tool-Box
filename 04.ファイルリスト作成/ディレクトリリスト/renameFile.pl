use strict;
use warnings;

# �t�@�C�����ύX
for (glob("*.java_new")) {
	my $old_name = $_;
	s/.java_new/.java/i;
	my $new_name = $_;
	print $new_name\n;
	rename $old_name, $new_name;
}
