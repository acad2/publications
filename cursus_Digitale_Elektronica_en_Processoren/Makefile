cursus.pdf: *.tex *sty *.bib
	pdflatex cursus.tex
	pdflatex cursus.tex
	bibtex cursus
	makeindex cursus
	bibtex cursus
	pdflatex cursus.tex
	pdflatex cursus.tex



clean:
	rm -f *.aux *.out *.pdf *.log *.bbl *.blg *~
