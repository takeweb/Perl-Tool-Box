use strict;
use warnings;
use Net::SSH::Perl;
use IO::Handle;

my $host = 'debian-server';
my $ssh = Net::SSH:Perl->new($host);
$ssh->login("takeweb", "take0014");
print $ssh->cmd("df");
$ssh->cmd("exit");

