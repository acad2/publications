sed "s/ó/\\\\'o/g" < $1 | sed "s/ê/\\\\^e/g" | sed "s/ö/\\\\\"o/g" > "/tmp/temporary.tex"
mv "/tmp/temporary.tex" $1
