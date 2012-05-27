use strict;
use warnings;

my @hulft_line;

while (my $line = <>) {

    $line =~ s/^\/home\/db_user\/tcap\/jcl/\/hulft\/apz17\/dba\/shl/g;                   #ESTIM      Ëapz17

    if ($line =~ /utlsend/) {
        print "$line\n";
#        @hulft_line = split(/ /, $line);
    }

#	print $line;
}
