#!/bin/sh
git checkout dep
cd "`dirname $0`"

renice -n 19 -p "$$"

while true
do
    for f in `seq 20`
    do
        make
        read -p 'press "q" to quit' -t 60 -n 1 -r a
        echo
        if [ "$a" == "q" ]
        then
            exit 0
        fi
    done
    make clean
done
