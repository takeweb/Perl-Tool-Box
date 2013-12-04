use strict;
use warnings;
use Time::Local;
use utf8;
use Encode qw/encode decode/;

#my %person1 = (name => 'Ken',  country => 'Japan', age => 19);
#my %person2 = (name => 'Taro', country => 'USA',   age => 45);

#my @persons = (\%person1, \%person2);


#foreach my $person (@persons) {
#    foreach my $key (keys %$person) {
#        my $value = $person->{$key};
#        print "$key : $value\n";
#    }
#}

print getWday(2013, 10, 1);

sub getWday {
    my $year = shift;
    my $tuki = shift;
    my $day = shift;

    my $wday = (localtime(timelocal(0, 0, 0, $day, $tuki, $year)))[6];
#   print $wday;
    my @wdays = ("日","月","火","水","木","金","土");
#   print "$wdays[$wday]\n";
    print encode('cp932', $wdays[$wday]) . "\n";
}


