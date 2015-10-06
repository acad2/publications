#!/bin/sh
git checkout dep
cd "`dirname $0`"

renice -n 19 -p "$$"

while true
do
    make
    sleep 60
done
