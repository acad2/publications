#!/bin/bash
cd "`dirname $0`"
nn=$(seq $1)
for n in $nn
do
	bibtex cursus.aux
	makeindex cursus.idx
	pdflatex -interaction batchmode cursus.tex
	sleep $2
done
