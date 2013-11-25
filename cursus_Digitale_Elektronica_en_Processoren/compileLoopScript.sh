#!/bin/sh
cd "`dirname $0`"
while true
do
	sleep 40
	rm cursus.pdf
	make
done
