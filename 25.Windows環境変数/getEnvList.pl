use strict;
use warnings;
use Win32::OLE;

# �ϐ��錾
my $WshShell = Win32::OLE->CreateObject("WScript.Shell");
my @SysEnv = $WshShell->Enviroment("SYSTEM");
my @UsrEnv = $WshShell->Enviroment("USER");

foreach my $value (@SysEnv) {
	print "�V�X�e�����ϐ��F$value\n";
}

foreach my $value (@UsrEnv) {
	print "���[�U���ϐ��F$value\n";
}

