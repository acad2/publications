#!/bin/sh
git checkout dep
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
	scp cursus.pdf ulyssis:www/dep.pdf
	git add .
	timeout 10 git commit -S -am "$msg"
	timeout 10 git commit -am "$msg"
	git push --all
done
