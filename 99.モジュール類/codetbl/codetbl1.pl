#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create ascii code table (JIS X0201)
# 

# JISローマ字（ASCII）の表示
print "\n●JISローマ字（ASCII）\n";

# スケールの表示
print "JIS  SJIS EUC   ";
print "+0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +A +B +C +D +E +F\n";

$line = "";
$c = 1; # 1行文字数(16文字)

for ($c1 = 0x20; $c1 <= 0x7F; $c1++) { # $c1は第1バイト

    if ($c == 1) { # コード変換
        $head = sprintf (" %02X   %02X   %02X  ",
            $c1, $c1, $c1);
    }

    # 文字の表示
    if ($c1 == 0x7F) {
        $line .= "   "; # 空白
    } else {
        $line .= "  "; # 文字間の空白
        $line .= pack("C", $c1);
    }

    if ($c == 16) { # 16文字目で1行表示
        print "$head$line\n";
        $line = "";
        $c = 1;
    } else {
        $c++;
    }
}


# JISカナ（半角カナ）の表示
print "\n●JISカナ（半角カナ）\n";

# スケールの表示
print "JIS  SJIS EUC   ";
print "+0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +A +B +C +D +E +F\n";

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

$line = "";
$c = 1; # 1行文字数(16文字)

for ($c1 = 0x20; $c1 <= 0x5F; $c1++) { # $c1は第1バイト

    if ($c == 1) { # コード変換
        ($c1_s, $c2_s) = &jis2sjis($c1);
        ($c1_e, $c2_e) = &jis2euc($c1);
        $head = sprintf (" %02X   %02X  %02X%02X ",
            $c1, $c1_s, $c1_e, $c2_e);
    } else {
        $c2_e++;
    }

    # 文字の表示
    $line .= " "; # 文字間の空白
    $line .= $han2zen[$c1 - 0x20];

    if ($c == 16) { # 16文字目で1行表示
        print "$head$line\n";
        $line = "";
        $c = 1;
    } else {
        $c++;
    }
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
