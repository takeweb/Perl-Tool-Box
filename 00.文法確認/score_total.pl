# ���@�`�F�b�N
use strict;
use warnings;

# �p��Ɛ��w�̓_��
my $score_math = 77;
my $score_english = 80;

# �p��Ɛ��w�̓_���̑����Z
my $score_total = $score_math + $score_english;

# �v�Z���ʂ����₷���`���ɕҏW
my $score_list = "Math     :$score_math\n" .
				 "English  :$score_english\n" .
				 "Total    :$score_total\n";

# �v�Z���ʂ̏o��
print $score_list;
	
