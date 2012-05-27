use strict;
use warnings;
use Net::Telnet;

my $host = 'tddbu91';
my $user = 'p000h06593';
my $pass = 'take5198';
my $prompt = '/\[.+\]\$ $/';
#my $prompt = '/[\$%#>] $/';
#my $prompt = "/\[NEW\-SP\:p000h06593\@tddbu91\:\/home\/p000h06593\] $/";

my $telnet = new Net::Telnet(
		Timeout => 10,
		Prompt => $prompt,
);

# 接続
$telnet->open($host);
$telnet->login($user, $pass);

my @result;
@result = $telnet->cmd("pwd");
print @result;

@result = $telnet->cmd("ls -laF");
print @result;

# 切断
$telnet->close;

