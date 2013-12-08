#!/bin/sh
if [ $# -le 0 ]
then
	msg="temp commit"
else
	msg=$1
fi
cd "`dirname $0`"
while true
do
	for i in {1..50}
	do
		make
		sleep 60
	done
	git commit -a -m "$msg"
done
