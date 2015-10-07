#!/bin/bash
git checkout dep
cd "`dirname $0`"

renice -n 19 -p "$$"

while true
do
    for f in `seq 20`
    do
        make >/dev/null 2>/dev/null
        read -t 60 -p 'press "q" to quit; any other key to continue ' -n 1 -r a
        echo ""
        if [[ "$a" =~ [qQ] ]]
        then
            exit 0
        fi
    done
    make clean >/dev/null 2>/dev/null
done
