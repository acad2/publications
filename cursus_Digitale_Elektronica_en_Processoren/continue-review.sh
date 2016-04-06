#!/bin/bash

mark='REVIEW'
delm=':'

while [ "$#" -gt '0' ]
  do
  mark="$1"
  shift
done

renice -n -10 -p "$$" >/dev/null 2>/dev/null

for rms in "`grep -H -n -P "%\\s*$mark" *.tex | tac`" #A tribute to Richard Matthew Stallman
  do
  fl=$(cut -d"$delm" -f 1 <<<$rms)
  ln=$(cut -d"$delm" -f 2 <<<$rms)
  vim +$ln "$fl"
done
echo "No more review markers found :("
