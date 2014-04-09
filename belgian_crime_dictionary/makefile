records.pdf: all.tex records.tex makefile biblio.bib
	bash distribute.sh
	pdflatex -interaction nonstopmode records.tex
	pdflatex -interaction nonstopmode records.tex
	bibtex records
	makeindex records
	makeglossaries records
	pdflatex -interaction nonstopmode records.tex
	pdflatex -interaction nonstopmode records.tex
	bibtex records
	makeindex records
	makeglossaries records
	pdflatex -interaction nonstopmode records.tex
	pdflatex -interaction nonstopmode records.tex


clean:
	rm -f *.aux *.out *.pdf *.log *.bbl *.blg *~
