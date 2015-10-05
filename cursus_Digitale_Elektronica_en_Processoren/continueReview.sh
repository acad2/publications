#!/bin/bash
grep -H -n -P '%\s*REVIEW' *.tex | while read rms
do
    fl=$(cut -d':' -f 1 <<<$rms)
    ln=$(cut -d':' -f 2 <<<$rms)
    vim +$ln "$fl" </dev/stdin
done
echo "No more review markers found :("
