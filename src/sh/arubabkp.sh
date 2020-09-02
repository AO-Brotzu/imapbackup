#!/bin/bash -x
#
uname=""
passwd=""
datarange=""
backupPath="./"
monthsago=0

while getopts ":u:p:d:b:m:" option; do
  case $option in
    u ) uname=$OPTARG
    ;;
    p ) passwd=$OPTARG
    ;;
    d ) datarange=${OPTARG}
    ;;
    b ) backupPath=${OPTARG}
    ;;
    m ) monthsago=${OPTARG}
    ;;
  esac
done

if [ "$uname" = "" ]; then
	echo -n "Username: "; read uname
else 
	echo "Username: $uname"
fi

if [ "$passwd" = "" ]; then
	echo -n "Password: "; stty -echo; read passwd; stty echo; echo
else 
	echo "Password set"
fi

if [ "$datarange" = "" ]; then
  # Example: '(since "27-Jul-2020" before "28-Jul-2020")'
  echo "datarange = $datarange"
fi 

echo "monthsago =  $monthsago"
if [ "$monthsago" \> 0 ]; then
    startDate=$(date --date="$(date +'%Y-%m-01') - $monthsago month" +%d-%b-%Y)
    endDate=$(date --date="$(date +'%Y-%m-01') - 1 second" +%d-%b-%Y)
    datarange="(since \"$startDate\" before \"$endDate\")"
    echo "datarange = $datarange"
fi

echo "python2.7 ../py/imapbackup.py -s imaps.pec.aruba.it -u $uname -p $passwd -d '$datarange' --backup-path=\"$backupPath\" --ssl --single-mbox" 
echo "python2.7 ../py/imapbackup.py -s imaps.pec.aruba.it -u $uname -p $passwd -d '$datarange' --backup-path=\"$backupPath\" --ssl --single-mbox" | bash
