use strict;
use warnings;
use utf8;

binmode( STDIN, ":encoding(utf8)");
binmode( STDOUT, ":encoding(utf8)");

while(<STDIN>) {
	tr/Ａ-Ｚａ-ｚ０-９！”＃＄％＆’（）／．\x{3000}/A-Za-z0-9!\"\#$%&'\(\)\/\.\x{0020}/;
	tr/A-Za-z0-9!\"\#$%&'\(\)\/\.\x{0020}/Ａ-Ｚａ-ｚ０-９！”＃＄％＆’（）／．\x{3000}/;
	print STDOUT $_;
}
