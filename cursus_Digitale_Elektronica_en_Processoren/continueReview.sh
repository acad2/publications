#!/bin/bash

renice -n -10 -p "$$" >/dev/null 2>/dev/null

for rms in "`grep -H -n -P '%\s*REVIEW' *.tex`" #A tribute to Richard Matthew Stallman
do
    fl=$(cut -d':' -f 1 <<<$rms)
    ln=$(cut -d':' -f 2 <<<$rms)
    vim +$ln "$fl"
done
echo "No more review markers found :("
