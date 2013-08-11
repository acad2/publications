#!/bin/bash

for p in {"*.~","*.*~*","*.backup","*.aux","*.bbl","*.blg","*.idx","*.ilg","*.ind","*.lof","*.log","*.lot","*.out","*.toc","*.mtc*","*.glo","*.maf","*.ist"}
do
	echo "$p"
	fall=$(find . -name "$p")
	echo "$fall"
	for f in $fall
	do
		echo "Removing $f..."
		rm "$f"
	done
done
