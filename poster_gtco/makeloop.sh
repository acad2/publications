#!/bin/bash
itv=15
if [ $# -gt 0 ]
then
    itv=$1
fi
while true
do
    make >/dev/null 2>/dev/null
    sleep "$itv"
done
