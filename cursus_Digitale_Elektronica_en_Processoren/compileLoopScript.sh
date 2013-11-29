#!/bin/sh
cd "`dirname $0`"
while true
do
	for i in {1..50}
	do
		make
		sleep 60
	done
	git commit -a -m "temporary commit"
done
