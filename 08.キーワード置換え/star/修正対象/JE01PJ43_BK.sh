#--------------------------------------------------#
# 決定単価送信処理(118537 RME）                    #
#   1.見積り単価データファイル作成                 #
#   Create:2011.02.14 By JCC Shiizu                #
#   Modify:                                        #
#   Modify:2011.04.26 By T.OHISHI                  #
#               UNIXディレクトリ変更対応           #
#--------------------------------------------------#
# 共通定義読み込み
. SH_COMMON_STAR.sh

#------------------------------#
#  初期設定                    #
#------------------------------#
#--- 共通                   ---#
#HOM_PASS="/home/db_user/star"
#JCL_PASS=$HOM_PASS'/batch/sh'
#LOG_PASS=$HOM_PASS'/batch/log'
#SQL_PASS=$HOM_PASS'/batch/sql'
#ORA_PASS='rvnnet/rvnnet'
ORA_PASS=${STAR_ORAID}'/'${STAR_ORAPW}
LOGF=$LOG_PASS'/JE01PJ43_BK.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`
ORDER_CD="118948A01"
#------------------------------#
#  初期処理                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  見積単価データファイル作成処理     #
#-------------------------------------#
# 見積単価データファイル作成
sqlplus $ORA_PASS @$SQL_PASS'/RINKS21_TANK_BM.sql' $LOGFWK $ORDER_CD
cat $LOGFWK>>$LOGF

exit
