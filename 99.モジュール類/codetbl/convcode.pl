#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# ʸ��������Ƚ�����
#

#
# JIS -> SJIS �������Ѵ�
#
sub jis2sjis {
    local($c1_j, $c2_j);
    local($c1_s, $c2_s);
    $c1_j = $_[0];
    $c2_j = $_[1];

    # 1�Х����ܤ��Ѵ�
    if ($c1_j < 0x5f) { # 21-5E -> 81-9F
        $c1_s = (($c1_j + 1) >> 1) + 0x70;
    } else { # 5F-7E -> E0-EF
        $c1_s = (($c1_j + 1) >> 1) + 0xb0;
    }

    # 2�Х����ܤ��Ѵ�
    if ($c1_j % 2) { # �����
        if ($c2_j < 0x60) { # 20-50 -> 3F-6F
            $c2_s = $c2_j + 0x1f;
        } else { # 60-70 -> 80-90
            $c2_s = $c2_j + 0x20;
        }
    } else { # 20-70 -> 9E-EE
        $c2_s = $c2_j + 0x7e;
    }

    return($c1_s, $c2_s);
}


#
# SJIS -> JIS �������Ѵ�
#
sub sjis2jis {
    local($c1_s, $c2_s);
    local($c1_j, $c2_j);
    $c1_s = $_[0];
    $c2_s = $_[1];

    # 1�Х����ܤ��Ѵ�
    if ($c1_s < 0xe0) { # 81-9F -> 21-5E
        $c1_j = ($c1_s - 0x70) << 1;
    } else { # E0-EF -> 5F-7E
        $c1_j = ($c1_s - 0xb0) << 1;
    }

    # 2�Х����ܤ��Ѵ�
    if ($c2_s < 0x9e) { # �����
        $c1_j--;
        if ($c2_j < 0x80) { # 3F-6F -> 20-50
            $c2_j = $c2_s - 0x1f;
        } else { # 80-90 -> 60-70
            $c2_j = $c2_s - 0x20;
        }
    } else { # 9E-EE -> 20-70
        $c2_j = $c2_s - 0x7e;
    }

    return($c1_j, $c2_j);
}


#
# JIS -> EUC �������Ѵ�
#
sub jis2euc {
    local($c1_j, $c2_j);
    local($c1_e, $c2_e);
    $c1_j = $_[0];
    $c2_j = $_[1];

    $c1_e = $c1_j | 0x80;
    $c2_e = $c2_j | 0x80;

    return($c1_e, $c2_e);
}


#
# EUC -> JIS �������Ѵ�
#
sub euc2jis {
    local($c1_e, $c2_e);
    local($c1_j, $c2_j);
    $c1_e = $_[0];
    $c2_e = $_[1];

    $c1_j = $c1_e & 0x7f;
    $c2_j = $c2_e & 0x7f;

    return($c1_j, $c2_j);
}


#
# SJIS -> EUC �������Ѵ�
#
sub sjis2euc {
    local($c1_s, $c2_s);
    local($c1_j, $c2_j);
    local($c1_e, $c2_e);
    $c1_s = $_[0];
    $c2_s = $_[1];

    ($c1_j, $c2_j) = sjis2jis($c1_s, $c2_s);

    $c1_e = $c1_j | 0x80;
    $c2_e = $c2_j | 0x80;

    return($c1_e, $c2_e);
}


#
# EUC -> SJIS �������Ѵ�
#
sub euc2sjis {
    local($c1_e, $c2_e);
    local($c1_j, $c2_j);
    local($c1_s, $c2_s);
    $c1_e = $_[0];
    $c2_e = $_[1];

    $c1_j = $c1_e & 0x7f;
    $c2_j = $c2_e & 0x7f;

    ($c1_s, $c2_s) = jis2sjis($c1_j, $c2_j);

    return($c1_s, $c2_s);
}


#
# JIS�����ɤ���Unicode�ؤ��Ѵ��ơ��֥�κ���
#
sub init_jis2uni {
    my $cj; # SJIS char
    my $cu; # Unicode char
    my $s;  # string buffer

    # �Ѵ��ơ��֥�Υ����ץ�
    $file_open = "<jis0208.txt";
    if (!open(FILE_IN, $file_open)) {
        printf("File open error.\n");
        exit(1);
    }

    while ($s = <FILE_IN>) {
        if ($s =~ /^#/) {next;} # ��Ƭ��'#'�ιԤ�̵��

        $cj = pack("H4", substr($s, 9, 4));  # JIS
        $cu = pack("H4", substr($s, 16, 4)); # Unicode

        $tbl_jis2uni{$cj} = $cu; # �Ѵ��ơ��֥�κ���
    }

    # �Ѵ��ơ��֥�Υ�����
    close(FILE_IN);
}


#
# JIS�����ɤ���Unicode�ؤ��Ѵ�
#
sub jis2uni {
    local($sj, $su);

    $sj = chr($_[0]).chr($_[1]);
    $su = $tbl_jis2uni{$sj};

    return(ord(substr($su, 0, 1)), ord(substr($su, 1, 1)));
}


#
# Unicode����UTF-8�ؤ��Ѵ�
#
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
