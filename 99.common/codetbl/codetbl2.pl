#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create code table (JIS X0208)
# 

# JIS������ɽ��
print "\n��JIS����\n";

for ($c1 = 0x21; $c1 <= 0x7E; $c1++) { # $c1����1�Х���

    # ���������ɽ��
    print "\n      JIS  SJIS EUC   ";
    print "+0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +A +B +C +D +E +F\n";

    # ���ֹ������
    $ku = $c1 - 0x20;

    $line = "";
    $c = 1; # 1��ʸ����(16ʸ��)

    for ($c2 = 0x20; $c2 <= 0x7F; $c2++) { # $c2����2�Х���

       	if ($c == 1) { # �������Ѵ�
            ($c1_s, $c2_s) = &jis2sjis($c1, $c2);
            ($c1_e, $c2_e) = &jis2euc($c1, $c2);
            $head = sprintf ("%02d��  %02X%02X %02X%02X %02X%02X ",
                $ku, $c1, $c2, $c1_s, $c2_s, $c1_e, $c2_e);
        } else {
            $c2_s++;
            $c2_e++;
        }

        if (($c2 == 0x20) || ($c2 == 0x7F)) {
            $line .= "   ";
        } else { # ʸ����ɽ��
            $line .= " "; # ʸ���֤ζ���
            $line .= pack("CC", $c1_e, $c2_e);
        }

        if ($c == 16) { # 16ʸ���ܤ�1��ɽ��
            print "$head$line\n";
            $line = "";
            $c = 1;
        } else {
            $c++;
        }
    }
}


exit;


# jis �����ɤ��� sjis �����ɤ��Ѵ�
sub jis2sjis {
    local($c1, $c2);

    # 1�Х����ܤ��Ѵ�
    if ($_[0] < 0x5f) { # 21-5E -> 81-9F
        $c1 = (($_[0] + 1) >> 1) + 0x70;
    } else { # 5F-7E -> E0-EF
        $c1 = (($_[0] + 1) >> 1) + 0xb0;
    }

    # 2�Х����ܤ��Ѵ�
    if ($_[0] % 2) { # �����
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


# jis �����ɤ��� euc �����ɤ��Ѵ�
sub jis2euc {
    return($_[0] | 0x80, $_[1] | 0x80);
}
