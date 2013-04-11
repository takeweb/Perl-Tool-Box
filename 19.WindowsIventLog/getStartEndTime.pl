#!perl

use strict;
use warnings;
use Win32::EventLog;

########################################################
# Windowsイベントログ収集(勤務時間)
#    第１引数:  取得対象年(省略時：2013)
#    第２引数:  取得対象月(省略時：11)
########################################################

my $tyear = shift || 2013;
my $tmon = shift || 11;
my $round_min = 1;

# イベントログ
my $syslog = Win32::EventLog->new("System");

# シーケンシャルに読み込む為に最初のレコード番号とレコード数を取得
my ($recs, $base, $ev, $n) = (0, 0, undef, 0);
$syslog->GetNumber($recs);
$syslog->GetOldest($base);

# シーケンシャルにレコード取得し、ID判定
my %sched;
while( $n < $recs) {
	$syslog->Read( EVENTLOG_FORWARDS_READ | EVENTLOG_SEEK_READ, $base + $n, $ev );
	
	my $id = ($ev->{EventID} & 0xffff );
	
	# イベントロガー開始(6005)又はイベントロガー停止(6006)なら時刻を取得
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) = localtime( $ev->{TimeGenerated} ); 
	if ( $id eq 6005 || $id eq 6006 ) {
#	if ( $id eq 12 || $id eq 13 ) {

		# 引数の年月と同じ場合
		if ( $year + 1900 eq $tyear && $mon + 1 eq $tmon ) {
			unless ( defined $sched{$mday} ) {
				$sched{$mday} = ();
			}
			
			if ($round_min) {
				# 開始時刻丸め
				$min = int( $min / $round_min + 1 ) * $round_min
#					if $id eq 6005 && ( $min % $round_min );
					if $id eq 12 && ( $min % $round_min );

				# 終了時刻丸め
				$min = int( $min / $round_min ) * $round_min
					if $id eq 6006 && ( $min % $round_min );
#					if $id eq 13 && ( $min % $round_min );

				$hour += int($min / 60);
				$min = $min % 60;
			}
			
			# 0は開始時刻の添え字、1は終了時刻の添え字
			my $which_is = $id eq 6005 ? 0 : 1;
#			my $which_is = $id eq 12 ? 0 : 1;
			
			# 日付がキーで値が2要素の配列で、それぞれ開始時刻と終了時刻を格納
			# 1日に複数回再起動を行うこともあるので、最初と最後を判定する。
			my $last = 0;
			if ( defined $sched{$mday} [$which_is] ) {
				$last = $sched{$mday}[$which_is];
				$last =~ s!:!!;
			}
			
			if (($which_is eq 0 && ( $last eq 0 || $last > $hour * 100 + $min )) 
				 || ( $which_is eq 1 && $last < $hour * 100 + $min ) ) {
				$sched{$mday} [$which_is] = sprintf "%02d:%02d", $hour, $min;
			}
		}
	}
	$n++;
}

# CSV出力
printf "DATE,START,END\n";
for ( sort { $a <=> $b } keys %sched ) {
	my ( $start, $end ) = ( $sched{$_}[0] || '', $sched{$_}[1] || '' );
	printf "%04d/%02d/%02d, %s, %s\n", $tyear, $tmon, $_, $start, $end;
}
