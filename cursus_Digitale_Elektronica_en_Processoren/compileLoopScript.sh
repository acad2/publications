#!/bin/bash
git checkout dep >/dev/null 2>/dev/null
cd "`dirname $0`"

renice -n 19 -p "$$" >/dev/null 2>/dev/null

while true
do
    for f in `seq 20`
    do
        make >/dev/null 2>/dev/null
        read -t 60 -p 'press "q" to quit; any other key to continue ' -n 1 -r a
        echo ""
        if [[ "$a" =~ [qQ] ]]
        then
            fs=$(wc -c cursus.pdf | cut -d' ' -f 1) #obtain the file size
            if [ "$fs" -gt "2000000" ] #if larger than 2 MB
            then
                scp cursus.pdf ulyssis:www/cursus_dep.pdf
            fi
            exit 0
        fi
    done
    make clean >/dev/null 2>/dev/null
done
