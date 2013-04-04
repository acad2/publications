#!/bin/sh
cd "`dirname $0`"
for k in {1..40}
do
	for n in {1..10}
	do
		bibtex cursus.aux
		makeindex cursus.idx
		pdflatex -interaction batchmode cursus.tex
		sleep 120
	done
	
	if [ $# -eq 0 ]
	then
		git commit -a -m "cursus DEP"
	else
		git commit -a -m "$1"
	fi
done
git push
