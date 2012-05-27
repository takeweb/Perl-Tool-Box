use strict;
use warnings;

#######################################################
# Oracle���v���擾���쐬
#    ������:  �X�L�[�}��
#    �W���o�́F SQL�t�@�C����SQL�����_�C���N�g
# �u�X�L�[�}��.txt�v�Ƃ����e�L�X�g�t�@�C����
#  �X�L�[�}�ɑ�����S�Ẵe�[�u�����o�͂��Ă������ƁB
########################################################

my $schema = $ARGV[0];
my $file = $schema . ".txt";

print "SET ECHO ON\n";
print "SET LINE 300\n";
print "set timing on\n";
print "spool GATHER_TABLE_STATS_$schema.log\n";

#�e�[�u�����X�g��ǂݍ���
open my $fh, '<', $file or die qq/Can't open file "$file" : $!/;
while (my $table = <$fh>) {
    chomp($table);
    print "EXECUTE DBMS_STATS.GATHER_TABLE_STATS ( owner => '$schema', tabname => '$table', estimate_percent => 20, block_sample => TRUE, method_opt => 'FOR ALL COLUMNS SIZE 75', cascade => TRUE);\n";
}
close $fh;
print "spool off\n";
print "exit\n";

