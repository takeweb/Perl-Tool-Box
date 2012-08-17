#!/bin/ksh
#--------------------------------------------------#
# RINKS21適用単価取込処理(東北R用)                 #
#                                                  #
#   Create:2011.03.23 By OKI(JCC)                  #
#                                                  #
#   Modify:2011.04.26 By T.OHISHI                  #
#               UNIXディレクトリ変更対応           #
#--------------------------------------------------#
# 共通定義読み込み
. SH_COMMON_STAR.sh


#----------#
# 変数宣言 #
#----------#
#--- Set Directory Path ---#
#HOM_PATH="/home/db_user/tcap"
#DATA_PATH=${HOM_PATH}
#LOG_PATH=${HOM_PATH}"/log"
#CTL_PATH=${HOM_PATH}"/ctl"

#--- Set File Names ---#
LOGNM="JF01PJ43.log"
DATANM="THR1MSRCV.TXT"
CTLNM="CRMTTKF_R03.CTL"

#--- Set File Path ---#
LOG_FL=${LOG_PATH}/${LOGNM}
DATA_FL=${DATA_PATH}/${DATANM}
CTL_FL=${CTL_PATH}/${CTLNM}

#--- Init ---#
RTN=0

#----------#
# 処理     #
#----------#
#--- Flie Exists and 0Byte Check ---#
if [[ -s $DATA_FL ]]
then
	#--- Oracle Data Load ---#
	sqlldr userid="rvnnet/rvnnet" control=$CTL_FL log=$LOG_FL data=$DATA_FL
	RTN=$?
	
	#--- SUCCESS ONLY ---#
	if [ $RTN = 0 ]
	then
		#--- Change File 0Byte ---#
		cat /dev/null > ${DATA_FL}
	fi
fi


#----------#
# 終了     #
#----------#
exit $RTN;
