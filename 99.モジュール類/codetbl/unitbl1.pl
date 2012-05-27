#!/usr/local/bin/perl
# Copyright (C)1995-2000 ASH multimedia lab. (http://ash.or.jp/)
#
# create ascii code table (JIS X0201)
# 

# �ǥХå�����ե饰 (0:OFF)
$dbg = 0;

# JIS�����ɤ���Unicode�ؤ��Ѵ��ơ��֥�κ���
&init_jis2uni();

if ($dbg) {
    # �Ѵ��ơ��֥�����Ƥγ�ǧ
    foreach $cj (keys %tbl_jis2uni) {
        $dj = unpack("H2", $cj);
        $du = unpack("H4", $tbl_jis2uni{$cj});
        print "$dj  $du\n";
    }
}

# JIS���޻���ASCII�ˤ�ɽ��
print "\n��JIS���޻���ASCII�ˡ�ʸ��������ɽ\n";

# ���Ф���ɽ��
print "\nJIS  SJIS EUC  UTF-8  UTF-16 ��\n";

for ($c1 = 0x20; $c1 <= 0x7E; $c1++) { # $c1����1�Х���
    # ʸ�������ɤ�ɽ��
    printf ("%02X   %02X   %02X  ", $c1, $c1, $c1);

    # Unicode�ؤ��Ѵ�
    ($c1_u, $c2_u) = &jis2uni($c1);

    if (($c1_u == 0) && ($c2_u == 0)) {
        printf (" ------ ------");

    } else {
        # Unicode(UTF-8)��ɽ��
        ($c1_u8, $c2_u8, $c3_u8) = &uni2utf8($c1_u, $c2_u);
        if ($c2_u8 eq '') {
            printf (" %02X    ", $c1_u8);
        } elsif ($c3_u8 eq '') {
            printf (" %02X%02X  ", $c1_u8, $c2_u8);
        } else {
            printf (" %02X%02X%02X", $c1_u8, $c2_u8, $c3_u8);
        }

        # Unicode(UTF-16)��ɽ��
        printf (" %02X%02X  ", $c1_u, $c2_u);
    }

    # ʸ����ɽ��
    $s = pack("C", $c1);
    printf (" %s\n", $s);
}


# JIS���ʡ�Ⱦ�ѥ��ʡˤ�ɽ��
print "\n��JIS���ʡ�Ⱦ�ѥ��ʡˡ�ʸ��������ɽ\n";

# Ⱦ�ѥ��ʤ������ѥ��ʤؤ��Ѵ��ơ��֥�
@han2zen = (
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
    "��","��","��","��","��","��","��","��",
);

# ���Ф���ɽ��
print "\nJIS  SJIS EUC  UTF-8  UTF-16 ��\n";

for ($c1 = 0x21; $c1 <= 0x5F; $c1++) { # $c1����1�Х���
    # �������Ѵ�
    ($c1_s, $c2_s) = &jis2sjis($c1);
    ($c1_e, $c2_e) = &jis2euc($c1);

    # ʸ�������ɤ�ɽ��
    printf ("%02X   %02X   %02X%02X", $c1, $c1_s, $c1_e, $c2_e);

    # Unicode�ؤ��Ѵ�
    ($c1_u, $c2_u) = &jis2uni($c1 | 0x80);

    if (($c1_u == 0) && ($c2_u == 0)) {
        printf (" ------ ------");

    } else {
        # Unicode(UTF-8)��ɽ��
        ($c1_u8, $c2_u8, $c3_u8) = &uni2utf8($c1_u, $c2_u);
        if ($c2_u8 eq '') {
            printf (" %02X    ", $c1_u8);
        } elsif ($c3_u8 eq '') {
            printf (" %02X%02X  ", $c1_u8, $c2_u8);
        } else {
            printf (" %02X%02X%02X", $c1_u8, $c2_u8, $c3_u8);
        }

        # Unicode(UTF-16)��ɽ��
        printf (" %02X%02X  ", $c1_u, $c2_u);
    }

    # ʸ����ɽ��
    $s = $han2zen[$c1 - 0x20];
    printf (" %s\n", $s);
}


exit;


# jis �����ɤ��� sjis �����ɤ��Ѵ�
sub jis2sjis {
    return($_[0] | 0x80, "");
}


# jis �����ɤ��� euc �����ɤ��Ѵ�
sub jis2euc {
    return(0x8e, $_[0]);
}

# JIS�����ɤ���Unicode�ؤ��Ѵ��ơ��֥�κ���
sub init_jis2uni {
    my $cj; # SJIS char
    my $cu; # Unicode char
    my $s;  # string buffer

    # �Ѵ��ơ��֥�Υ����ץ�
    $file_open = "<jis0201.txt";
    if (!open(FILE_IN, $file_open)) {
        printf("File open error.\n");
        exit(1);
    }

    while ($s = <FILE_IN>) {
        if ($s =~ /^#/) {next;} # ��Ƭ��'#'�ιԤ�̵��

        $cj = pack("H2", substr($s, 2, 2)); # JIS
        $cu = pack("H4", substr($s, 7, 4)); # Unicode

        $tbl_jis2uni{$cj} = $cu; # �Ѵ��ơ��֥�κ���
    }

    # �Ѵ��ơ��֥�Υ�����
    close(FILE_IN);
}


# JIS�����ɤ���Unicode�ؤ��Ѵ�
sub jis2uni {
    local($sj, $su);

    $sj = chr($_[0]);
    $su = $tbl_jis2uni{$sj};

    return(ord(substr($su, 0, 1)), ord(substr($su, 1, 1)));
}


# Unicode����UTF-8�ؤ��Ѵ�
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
