#!/bin/sh
cd "`dirname $0`"
while true
do
	sleep 40
	makeindex cursus.idx
	pdflatex -interaction nonstopmode cursus.tex
	echo "$IFS"
done
