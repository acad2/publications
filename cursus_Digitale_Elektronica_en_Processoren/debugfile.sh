#!/bin/bash

lgf="logger.dat"
fle="$1"
tmo=120

for lb in `grep -h -n "^\.\/$1:[0-9]*:" "$lgf" | cut -d':' -f 1`
do
    tail -n "+$lb" "$lgf" | grep -m 1 '^l\.' -B 999
    read -t $tmo -p 'press "e" to edit; wait or press any key to continue? ' -n 1 -r a
    if [[ "$a" =~ [eE] ]]
    then
        la=$(tail -n "+$lb" "$lgf" | grep -m 1 '^l\.' | grep -m 1 '[0-9]*' -o)
        vim +"$la" "$fle"
    fi
done

