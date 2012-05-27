#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create code table (JIS X0208)
# 

# デバッグ制御フラグ (0:OFF)
$dbg = 0;

# JISコードからUnicodeへの変換テーブルの作成
&init_jis2uni();

if ($dbg) {
    # 変換テーブルの内容の確認
    foreach $cj (keys %tbl_jis2uni) {
        $dj = unpack("H4", $cj);
        $du = unpack("H4", $tbl_jis2uni{$cj});
        print "$dj  $du\n";
    }
}

print "\n●JIS漢字・文字コード表\n";

for ($c1 = 0x21; $c1 <= 0x7E; $c1++) { # $c1は第1バイト（区）
    # 見出しの表示
    print "\n区 点 JIS  SJIS EUC  UTF-8  UTF-16 字\n";

    # 区番号の設定
    $ku = $c1 - 0x20;

    for ($c2 = 0x21; $c2 <= 0x7E; $c2++) { # $c2は第2バイト（点）
        # 点番号の設定
        $ten = $c2 - 0x20;

        # 区点番号の表示
        printf ("%02d %02d", $ku, $ten);

        # JISコードの表示
        printf (" %02X%02X", $c1, $c2);

        # SJISコードの表示
        ($c1_s, $c2_s) = &jis2sjis($c1, $c2);
        printf (" %02X%02X", $c1_s, $c2_s);

        # EUCコードの表示
        ($c1_e, $c2_e) = &jis2euc($c1, $c2);
        printf (" %02X%02X", $c1_e, $c2_e);

        # Unicodeへの変換
        ($c1_u, $c2_u) = &jis2uni($c1, $c2);

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

        #  文字の表示
        $str = pack("CC", $c1_e, $c2_e);
        printf (" %s\n", $str);
    }
}

exit;


# jis コードから sjis コードに変換
sub jis2sjis {
    local($c1, $c2);

    # 1バイト目の変換
    if ($_[0] < 0x5f) { # 21-5E -> 81-9F
        $c1 = (($_[0] + 1) >> 1) + 0x70;
    } else { # 5F-7E -> E0-EF
        $c1 = (($_[0] + 1) >> 1) + 0xb0;
    }

    # 2バイト目の変換
    if ($_[0] % 2) { # 奇数区
        if ($_[1] < 0x60) { # 20-50 -> 3F-6F
            $c2 = $_[1] + 0x1f;
        } else { # 60-70 -> 80-90
            $c2 = $_[1] + 0x20;
        }
    } else { # 20-70 -> 9E-EE
        $c2 = $_[1] + 0x7e;
    }

    return($c1, $c2);
}


# jis コードから euc コードに変換
sub jis2euc {
    return($_[0] | 0x80, $_[1] | 0x80);
}


# JISコードからUnicodeへの変換テーブルの作成
sub init_jis2uni {
    my $cj; # SJIS char
    my $cu; # Unicode char
    my $s;  # string buffer

    # 変換テーブルのオープン
    $file_open = "<jis0208.txt";
    if (!open(FILE_IN, $file_open)) {
        printf("File open error.\n");
        exit(1);
    }

    while ($s = <FILE_IN>) {
        if ($s =~ /^#/) {next;} # 先頭が'#'の行を無視

        $cj = pack("H4", substr($s, 9, 4));  # JIS
        $cu = pack("H4", substr($s, 16, 4)); # Unicode

        $tbl_jis2uni{$cj} = $cu; # 変換テーブルの作成
    }

    # 変換テーブルのクローズ
    close(FILE_IN);
}

# JISコードからUnicodeへの変換
sub jis2uni {
    local($sj, $su);

    $sj = chr($_[0]).chr($_[1]);
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
