#--------------------------------------------------#
# ����P�����M����(108260D01 ���i���j              #
#   1.���ς�P���f�[�^�t�@�C���쐬                 #
#   Create:2011.03.22 By A.Taru                    #
#   Modify:                                        #
#   Modify:2011.04.26 By T.OHISHI                  #
#               UNIX�f�B���N�g���ύX�Ή�           #
#--------------------------------------------------#
# ���ʒ�`�ǂݍ���
. SH_COMMON_STAR.sh

#------------------------------#
#  �����ݒ�                    #
#------------------------------#
#--- ����                   ---#
#HOM_PASS="/home/db_user/star"
#JCL_PASS=$HOM_PASS'/batch/sh'
#LOG_PASS=$HOM_PASS'/batch/log'
#SQL_PASS=$HOM_PASS'/batch/sql'
#ORA_PASS='star/star'
LOGF=$LOG_PASS'/RIU1TM09_start.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`
HULFT_ID="RIU1TM09"
ORDER_CD="108260D01"
OUT_FILE="BUHNMSSND.TXT"
#------------------------------#
#  ��������                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  ���ϒP���f�[�^�t�@�C���쐬����     #
#-------------------------------------#
# ���ϒP���f�[�^�t�@�C���쐬
sqlplus $ORA_PASS @$SQL_PASS'/RIU1TM_HONBAN.SQL' $LOGFWK $HOM_PASS $HULFT_ID $ORDER_CD $OUT_FILE
cat $LOGFWK>>$LOGF

exit
