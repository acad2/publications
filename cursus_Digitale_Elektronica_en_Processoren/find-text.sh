#!/bin/bash

delm=':'

while [ "$#" -gt 0 ]
  do
  qr="$1"
  shift
  echo "$qr"

  for rms in "`grep -H -n -i "$qr" *.tex | tac`" #A tribute to Richard Matthew Stallman
    do
    fl=$(cut -d"$delm" -f 1 <<<$rms)
    ln=$(cut -d"$delm" -f 2 <<<$rms)
    if [ -f "$fl" ]
      then
      vim +$ln "$fl"
    fi
  done
done
echo "No more editing to be done :)"
