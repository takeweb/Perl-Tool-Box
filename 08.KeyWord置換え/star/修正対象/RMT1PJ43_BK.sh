#--------------------------------------------------#
# ����P�����M����(118537 RME�j                    #
#   1.���ς�P���f�[�^�t�@�C���쐬                 #
#   Create:2011.02.14 By JCC Shiizu                #
#   Modify:                                        #
#--------------------------------------------------#
#------------------------------#
#  �����ݒ�                    #
#------------------------------#
#--- ����                   ---#
HOM_PASS="/home/db_user/star"
JCL_PASS=$HOM_PASS'/batch/sh'
LOG_PASS=$HOM_PASS'/batch/log'
SQL_PASS=$HOM_PASS'/batch/sql'
ORA_PASS='rvnnet/rvnnet'
LOGF=$LOG_PASS'/RMT1PJ43_BK.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`
ORDER_CD="RMT1010"
#------------------------------#
#  ��������                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  ���ϒP���f�[�^�t�@�C���쐬����     #
#-------------------------------------#
# ���ϒP���f�[�^�t�@�C���쐬
sqlplus $ORA_PASS @$SQL_PASS'/RINKS21_TANK_BM.sql' $LOGFWK $ORDER_CD
cat $LOGFWK>>$LOGF

exit
