records.pdf: all.tex records.tex makefile biblio.bib
	bash distribute.sh
	bash makepdf.sh
	make clean

clean:
	rm -f *.aux *.out *.pdf *.log *.bbl *.blg *~ *.texp
