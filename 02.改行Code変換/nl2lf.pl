#/usr/bin/perl

use strict;
use warnings;

# 改行コード定数
use constant {
	UNIX_LF => "\x0A",
	WIN_CRLF => "\x0D\x0A",
	MAC_CR => "\x0D"	
};

binmode STDOUT;
while(<STDIN>) {
	print convert_nl($_, UNIX_LF);
}

sub convert_nl {
#	$_[0] =~ s/\x0D\x0A|\x0D|\0A/$_[1]/g;
	$_[0] =~ s/WIN_CRLF|MAC_CR|UNIX_LF/$_[1]/g;
	$_[0];
}
