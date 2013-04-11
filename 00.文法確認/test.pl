use strict;
use warnings;

my %person1 = (name => 'Ken',  country => 'Japan', age => 19);
my %person2 = (name => 'Taro', country => 'USA',   age => 45);

my @persons = (\%person1, \%person2);


foreach my $person (@persons) {
    foreach my $key (keys %$person) {
        my $value = $person->{$key};
        print "$key : $value\n";
    }
}