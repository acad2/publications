#!/bin/bash

mark=$(echo "$@")
delm=':'

qr="\\\\gtermen[^\{]*{$mark"
echo "$qr"

for rms in "`grep -H -n -P -i "$qr" *.tex | tac`" #A tribute to Richard Matthew Stallman
  do
  fl=$(cut -d"$delm" -f 1 <<<$rms)
  ln=$(cut -d"$delm" -f 2 <<<$rms)
  if [ -f "$fl" ]
    then
    vim +$ln "$fl"
  fi
done
echo "No more glossary entries found :("
