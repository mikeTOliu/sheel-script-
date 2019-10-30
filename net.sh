#!/bin/bash
date >> pinglog.txti
date>catchlog.txt
for ((i=1;i<=3;i++))
do
	a='192.168.100.'$i
	ping -I 192.168.100.1 -c 1 $a>/dev/null
	if [ $? -eq 0 ]
	then 
	        echo yes
	else
		echo no
		echo $a>>pinglog.txt
		echo $a>>catchlog.txt
	fi
done
if [ $(cat catchlog.txt|wc -l) -eq 1 ]
then
	echo 'every ok'
else
	msg=$(cat catchlog.txt|sed 's/$/++/g;s/ /++/g')
	msg=$(echo $msg|sed 's/ //g;s/\n\r//g')
	echo $msg
	url='https://sc.ftqq.com/SCU15823T6292b3331fc7fb362ab3d5e05718b02e5cd024e2cdb7d.send?text=error&desp='$msg
	curl $url
fi


