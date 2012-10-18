use strict;
use warnings;

for ( my $i = 1; $i <= 100; $i++ ) {
	if ( $i % 3 == 0 ) {
		if( $i % 5 == 0 ) {
			print( "FizzBuzz\n" );
		} else {
			print( "Fizz\n" );
		}
	} elsif( $i % 5 == 0 ) {
		print( "Buzz\n" );
	} else {
		print( "$i\n" );
	}
}
