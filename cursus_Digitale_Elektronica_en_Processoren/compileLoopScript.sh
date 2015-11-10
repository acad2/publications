#!/bin/bash

git checkout dep >/dev/null 2>/dev/null
cd "`dirname $0`"

#Time management
dtz=16200 #Commit and stats every four and a half hours

#Files and servers
pdff="cursus.pdf"
pdfu="ulyssis:www/cursus_dep.pdf"
stdo="logger.dat"
stde="errors.dat"
stds="stats.stat"
prfx="old-"

#Initial time
tmz=$(date +%s)
tmio=0
tmi=0

renice -n 19 -p "$$" >/dev/null 2>/dev/null

while true
    do
    while [ "$tmi" -le "$tmio" ]
        do
        make $pdff >$stdo 2>$stde

        grep -q '^make: .* is up to date.$' $stdo

        if [ "$?" -ne "0" ]
            then
            cp "$stdo" "$prfx$stdo"
            cp "$stde" "$prfx$stde"
        fi

        read -t 60 -p 'press "p" to purge, "q" to quit; "u" to upload; any other key to continue ' -n 1 -r a
        echo ""

        if [[ "$a" =~ [pP] ]]
            then
            make purge
        elif [[ "$a" =~ [uU] ]]
            then
            scp "$pdff" "$pdfu"
        elif [[ "$a" =~ [qQ] ]]
            then
            fs=$(wc -c "$pdff" | cut -d' ' -f 1) #obtain the file size
            if [ "$fs" -gt "2000000" ] #if larger than 2 MB
                then
                make purge
                make $pdff >$stdo 2>$stde
                scp "$pdff" "$pdfu"
            fi
            exit 0
        fi

    tmn=$(date +%s)
    tmi=$((($tmn-$tmz)/$dtz))

    done

    tmio="$tmi"

    bash generate-stats.sh >> "$stds"
    gnuplot diagnostics.gnplt

    make purge >/dev/null 2>/dev/null

    git commit -am 'temporary commit'

done
