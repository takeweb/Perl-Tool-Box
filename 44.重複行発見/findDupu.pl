use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;
use File::Find;

## 実行例
#  perl marge.pl 2013-07-19>result3.txt
##

$\ = "\n";

#コマンドライン引数の受取
my ($target_dir) = @ARGV;

my %all_hs;

# 引数で対象ディレクトリを受け取り、findへ引き渡し
find(\&wanted, $target_dir);

# 再帰呼出関数
sub wanted{
    my $path = $File::Find::name;
    return unless $path =~ /\_ja.properties$/;
#   print "$path\n";

    open my $fh, '<', $path
	or die qq{Can't open file "$path": $!};

    # 1行をキーと値に分割
    while (my $line = <$fh>) {
	next if $line =~ /^\n|^\#/;

	chomp $line;
#	print $line;
	
	my @cols= split('\=', $line);

	my $key = shift(@cols);
	my $value = shift(@cols);

	if ( exists($all_hs{$key})  ) {
	    print $path . "," . $key . "," . $all_hs{$key};
	} else {
	    $all_hs{$key} = $path;
	}

    }
    close $fh;
}

# 前後の空白文字削除
sub trim {
    my $val = shift;
    $val =~ s/^\s*(.*?)\s*$/$1/;

    return $val;
}

# 先頭の空白文字を削除
#sub ltrim {
#    my $val = shift;
#    $val =~ s/^\s*//;
#
#    return $val;
#}

# 末尾の空白文字を削除
#sub rtrim {
#    my $val = shift;
#    $val =~ s/\s*$//;
#    
#    return $val;
#}

