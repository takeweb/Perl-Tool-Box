#--------------------------------------------------#
# ����P�����M����(120561 �����R�[�j               #
#   1.���ς�P���f�[�^�t�@�C���쐬                 #
#   Create:2011.02.14 By JCC Shiizu                #
#   Modify:2011.03.10 By JCC Kitahara              #
#                     ��Oracle�p�X�ύX�Ή�         #
#--------------------------------------------------#
#------------------------------#
#  �����ݒ�                    #
#------------------------------#

#���ʒ�`�Ǎ�
. SH_COMMON_STAR.sh

#--- ����                   ---#
#HOM_PASS="/home/db_user/star"
#JCL_PASS=$HOM_PASS'/batch/sh'
#LOG_PASS=$HOM_PASS'/batch/log'
#SQL_PASS=$HOM_PASS'/batch/sql'
#ORA_PASS='star/star'
ORA_PASS=${STAR_ORAID}'/'${STAR_ORAPW}
LOGF=$LOG_PASS'/RIU1TM17_start.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`
HULFT_ID="RIU1TM17"
ORDER_CD="120561"
OUT_FILE="HSMMSSND.TXT"
#------------------------------#
#  ��������                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  ���ϒP���f�[�^�t�@�C���쐬����     #
#-------------------------------------#
# ���ϒP���f�[�^�t�@�C���쐬
#sqlplus $ORA_PASS @$SQL_PASS'/RIU1TM_HONABN.SQL' $LOGFWK $HOM_PASS $HULFT_ID $ORDER_CD $OUT_FILE
sqlplus $ORA_PASS @$SQL_PASS'/RIU1TM_HONBAN.SQL' $LOGFWK ${FOUT_PATH} $HULFT_ID $ORDER_CD $OUT_FILE
cat $LOGFWK>>$LOGF

exit
