while true
do
	bibtex cursus.aux
	makeindex cursus.idx
	pdflatex -interaction batchmode cursus.tex
	sleep 120
done
