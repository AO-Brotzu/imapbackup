#!/bin/bash -x
#
uname=""
passwd=""
datarange=""
backupPath="./"

while getopts ":u:p:d:b:" option; do
  case $option in
    u ) uname=$OPTARG
    ;;
    p ) passwd=$OPTARG
    ;;
    d ) datarange=${OPTARG}
    ;;
    b ) backupPath=${OPTARG}
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

echo "python ../py/imapbackup.py -s imaps.pec.aruba.it -u $uname -p $passwd -d '$datarange' --backup-path=\"$backupPath\" --ssl" 

echo "python ../py/imapbackup.py -s imaps.pec.aruba.it -u $uname -p $passwd -d '$datarange' --backup-path=\"$backupPath\" --ssl" | bash
