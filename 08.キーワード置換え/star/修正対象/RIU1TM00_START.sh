#--------------------------------------------------#
# 決定単価送信処理(108260SOUSA 操作練習用）TEST    #
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
#ORA_PASS='star/star'
LOGF=$LOG_PASS'/RIU1TM00_start.log'
BackDate=`date '+.%Y%m%d%H'`
SDATE=`date '+%Y%m%d'`
HULFT_ID="RIU1TM00"
ORDER_CD="108260SOUSA"
OUT_FILE="TESTTANKA_SQL.TXT"
#------------------------------#
#  初期処理                    #
#------------------------------#
LOGFWK=$LOGF'.WK'
if [[ -a $LOGFWK ]] then  rm $LOGFWK; fi

#-------------------------------------#
#  見積単価データファイル作成処理     #
#-------------------------------------#
# 見積単価データファイル作成
sqlplus $ORA_PASS @$SQL_PASS'/RIU1TM_TEST.SQL' $LOGFWK $HOM_PASS $HULFT_ID $ORDER_CD $OUT_FILE
cat $LOGFWK>>$LOGF

exit
