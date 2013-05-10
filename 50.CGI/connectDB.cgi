#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use CGI;

$\ = "\n";

my $cgi = new CGI();

print $cgi->header(-type=>'text/html',-charset=>'UTF-8');
print $cgi->start_html(-title=>'CGIテスト', -lang=>'ja');

my $dbh = &connect;

&select($dbh);

# DB接続
sub connect {
   my $database = 'test.db';
   my $data_source = "dbi:SQLite:dbname=$database";
   #my $data_source = "dbi:SQLite:dbname=:memory:";
   my $dbh = DBI->connect($data_source);
   return $dbh;
}

# テーブル作成
#sub create {
#    my $sql1 = <<"EOS";
#    CREATE TABLE book(
#        title,
#        author
#    );
#    EOS
#    $dbh->do($sql1);
#}

# データ挿入
sub insert {
    my $sql = "INSERT INTO book(title, author) VALUES (?, ?);";
    my $sth = $dbh->prepare($sql2);
    $sth->execute('Perl', 'taro');
    $sth->execute('ゲゲゲの女房', 'ああああ');
    $sth->execute('独習Java', 'taro');
    $sth->execute('独習Arduino', 'taro');
}

# データ選択
sub select {
    my $dbh = shift;
    my $sql = "SELECT title, author FROM book;";
    my $sth = $dbh->prepare($sql);
    $sth->execute;

    print "<table border='1'>";
    print "<th>書名</th><th>著者</th>";
    while (my @row = $sth->fetchrow_array) {
	print "<tr>";
	foreach my $col (@row) {
	    print "<td>" . $col . "</td>";
	}
	print "</tr>";
    }
    print "</table>";
}

$dbh->disconnect;

print $cgi->end_html();
