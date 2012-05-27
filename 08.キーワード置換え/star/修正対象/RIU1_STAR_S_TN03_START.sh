#--------------------------------------------------#
# 決定単価送信処理(RIU1 STAR経由）                 #
#   1.見積り単価データファイル作成                 #
#   Create:2011.02.14 By JCC Shiizu                #
#   Modify:                                        #
#--------------------------------------------------#
#------------------------------#
#  初期設定                    #
#------------------------------#
#--- 共通                   ---#
HOM_PASS="/home/db_user/star"
JCL_PASS=$HOM_PASS'/batch/sh'
LOG_PASS=$HOM_PASS'/batch/log'
SQL_PASS=$HOM_PASS'/batch/sql'
ORA_PASS='star/star'
LOGF=$LOG_PASS'/RIU1_TN03_start.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`


#------------------------------#
#  初期処理                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  見積単価データファイル作成処理     #
#-------------------------------------#
# 見積単価データファイル作成
sqlplus $ORA_PASS @$SQL_PASS'/RIU1_STAR_SEIKI_HONBAN.SQL' $LOGFWK 
cat $LOGFWK>>$LOGF

exit
