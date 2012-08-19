#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create ascii code table (JIS X0201)
# 

# デバッグ制御フラグ (0:OFF)
$dbg = 0;

# JISコードからUnicodeへの変換テーブルの作成
&init_jis2uni();

if ($dbg) {
    # 変換テーブルの内容の確認
    foreach $cj (keys %tbl_jis2uni) {
        $dj = unpack("H2", $cj);
        $du = unpack("H4", $tbl_jis2uni{$cj});
        print "$dj  $du\n";
    }
}

# JISローマ字（ASCII）の表示
print "\n●JISローマ字（ASCII）・文字コード表\n";

# 見出しの表示
print "\nJIS  SJIS EUC  UTF-8  UTF-16 字\n";

for ($c1 = 0x20; $c1 <= 0x7E; $c1++) { # $c1は第1バイト
    # 文字コードの表示
    printf ("%02X   %02X   %02X  ", $c1, $c1, $c1);

    # Unicodeへの変換
    ($c1_u, $c2_u) = &jis2uni($c1);

    if (($c1_u == 0) && ($c2_u == 0)) {
        printf (" ------ ------");

    } else {
        # Unicode(UTF-8)の表示
        ($c1_u8, $c2_u8, $c3_u8) = &uni2utf8($c1_u, $c2_u);
        if ($c2_u8 eq '') {
            printf (" %02X    ", $c1_u8);
        } elsif ($c3_u8 eq '') {
            printf (" %02X%02X  ", $c1_u8, $c2_u8);
        } else {
            printf (" %02X%02X%02X", $c1_u8, $c2_u8, $c3_u8);
        }

        # Unicode(UTF-16)の表示
        printf (" %02X%02X  ", $c1_u, $c2_u);
    }

    # 文字の表示
    $s = pack("C", $c1);
    printf (" %s\n", $s);
}


# JISカナ（半角カナ）の表示
print "\n●JISカナ（半角カナ）・文字コード表\n";

# 半角カナから全角カナへの変換テーブル
@han2zen = (
    "　","。","「","」","、","・","ヲ","ァ",
    "ィ","ゥ","ェ","ォ","ャ","ュ","ョ","ッ",
    "ー","ア","イ","ウ","エ","オ","カ","キ",
    "ク","ケ","コ","サ","シ","ス","セ","ソ",
    "タ","チ","ツ","テ","ト","ナ","ニ","ヌ",
    "ネ","ノ","ハ","ヒ","フ","ヘ","ホ","マ",
    "ミ","ム","メ","モ","ヤ","ユ","ヨ","ラ",
    "リ","ル","レ","ロ","ワ","ン","゛","゜",
);

# 見出しの表示
print "\nJIS  SJIS EUC  UTF-8  UTF-16 字\n";

for ($c1 = 0x21; $c1 <= 0x5F; $c1++) { # $c1は第1バイト
    # コード変換
    ($c1_s, $c2_s) = &jis2sjis($c1);
    ($c1_e, $c2_e) = &jis2euc($c1);

    # 文字コードの表示
    printf ("%02X   %02X   %02X%02X", $c1, $c1_s, $c1_e, $c2_e);

    # Unicodeへの変換
    ($c1_u, $c2_u) = &jis2uni($c1 | 0x80);

    if (($c1_u == 0) && ($c2_u == 0)) {
        printf (" ------ ------");

    } else {
        # Unicode(UTF-8)の表示
        ($c1_u8, $c2_u8, $c3_u8) = &uni2utf8($c1_u, $c2_u);
        if ($c2_u8 eq '') {
            printf (" %02X    ", $c1_u8);
        } elsif ($c3_u8 eq '') {
            printf (" %02X%02X  ", $c1_u8, $c2_u8);
        } else {
            printf (" %02X%02X%02X", $c1_u8, $c2_u8, $c3_u8);
        }

        # Unicode(UTF-16)の表示
        printf (" %02X%02X  ", $c1_u, $c2_u);
    }

    # 文字の表示
    $s = $han2zen[$c1 - 0x20];
    printf (" %s\n", $s);
}


exit;


# jis コードから sjis コードに変換
sub jis2sjis {
    return($_[0] | 0x80, "");
}


# jis コードから euc コードに変換
sub jis2euc {
    return(0x8e, $_[0]);
}

# JISコードからUnicodeへの変換テーブルの作成
sub init_jis2uni {
    my $cj; # SJIS char
    my $cu; # Unicode char
    my $s;  # string buffer

    # 変換テーブルのオープン
    $file_open = "<jis0201.txt";
    if (!open(FILE_IN, $file_open)) {
        printf("File open error.\n");
        exit(1);
    }

    while ($s = <FILE_IN>) {
        if ($s =~ /^#/) {next;} # 先頭が'#'の行を無視

        $cj = pack("H2", substr($s, 2, 2)); # JIS
        $cu = pack("H4", substr($s, 7, 4)); # Unicode

        $tbl_jis2uni{$cj} = $cu; # 変換テーブルの作成
    }

    # 変換テーブルのクローズ
    close(FILE_IN);
}


# JISコードからUnicodeへの変換
sub jis2uni {
    local($sj, $su);

    $sj = chr($_[0]);
    $su = $tbl_jis2uni{$sj};

    return(ord(substr($su, 0, 1)), ord(substr($su, 1, 1)));
}


# UnicodeからUTF-8への変換
sub uni2utf8 {
    local ($c1, $c2, $c3);

    $n = $_[0] * 0x100 + $_[1];

    if ($n < 0x7F) { # 0000-007F
        $c1 = $n;
        return($c1);

    } elsif ($n < 0x800) { # 0080-0800
        $c1 = 0xC0 | ($n / 64);
        $c2 = 0x80 | ($n % 64);
        return($c1, $c2);

    } else { # 0800-FFFF
        $c1 = 0xE0 | (($n / 64) / 64);
        $c2 = 0x80 | (($n / 64) % 64);
        $c3 = 0x80 | ($n % 64);
        return($c1, $c2, $c3);
    }
}

1;
