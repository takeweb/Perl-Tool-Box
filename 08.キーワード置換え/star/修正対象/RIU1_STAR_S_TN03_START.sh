#--------------------------------------------------#
# ����P�����M����(RIU1 STAR�o�R�j                 #
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
ORA_PASS='star/star'
LOGF=$LOG_PASS'/RIU1_TN03_start.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`


#------------------------------#
#  ��������                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  ���ϒP���f�[�^�t�@�C���쐬����     #
#-------------------------------------#
# ���ϒP���f�[�^�t�@�C���쐬
sqlplus $ORA_PASS @$SQL_PASS'/RIU1_STAR_SEIKI_HONBAN.SQL' $LOGFWK 
cat $LOGFWK>>$LOGF

exit
