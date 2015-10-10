#!/bin/bash

fle="$1"

for lb in `grep -h -n "^\.\/$1:[0-9]*:" "logger.dat" | cut -d':' -f 1`
do
   
done

