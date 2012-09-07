use strict;
use warnings;
use Win32::OLE;

# 変数宣言
my $WshShell = Win32::OLE->CreateObject("WScript.Shell");
my @SysEnv = $WshShell->Enviroment("SYSTEM");
my @UsrEnv = $WshShell->Enviroment("USER");

foreach my $value (@SysEnv) {
	print "システム環境変数：$value\n";
}

foreach my $value (@UsrEnv) {
	print "ユーザ環境変数：$value\n";
}

