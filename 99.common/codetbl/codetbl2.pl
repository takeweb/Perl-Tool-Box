#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create code table (JIS X0208)
# 

# JIS漢字の表示
print "\n●JIS漢字\n";

for ($c1 = 0x21; $c1 <= 0x7E; $c1++) { # $c1は第1バイト

    # スケールの表示
    print "\n      JIS  SJIS EUC   ";
    print "+0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +A +B +C +D +E +F\n";

    # 区番号の設定
    $ku = $c1 - 0x20;

    $line = "";
    $c = 1; # 1行文字数(16文字)

    for ($c2 = 0x20; $c2 <= 0x7F; $c2++) { # $c2は第2バイト

       	if ($c == 1) { # コード変換
            ($c1_s, $c2_s) = &jis2sjis($c1, $c2);
            ($c1_e, $c2_e) = &jis2euc($c1, $c2);
            $head = sprintf ("%02d区  %02X%02X %02X%02X %02X%02X ",
                $ku, $c1, $c2, $c1_s, $c2_s, $c1_e, $c2_e);
        } else {
            $c2_s++;
            $c2_e++;
        }

        if (($c2 == 0x20) || ($c2 == 0x7F)) {
            $line .= "   ";
        } else { # 文字の表示
            $line .= " "; # 文字間の空白
            $line .= pack("CC", $c1_e, $c2_e);
        }

        if ($c == 16) { # 16文字目で1行表示
            print "$head$line\n";
            $line = "";
            $c = 1;
        } else {
            $c++;
        }
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
