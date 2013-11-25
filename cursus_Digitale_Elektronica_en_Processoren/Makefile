cursus.pdf: *.tex *.bib *.sty
	pdflatex --interaction nonstopmode cursus.tex || true
	makeglossaries cursus || true
	makeindex cursus || true
	pdflatex --interaction nonstopmode cursus.tex || true
	bibtex cursus || true
	makeglossaries cursus || true
	makeindex cursus || true
	pdflatex --interaction nonstopmode cursus.tex || true
	bibtex cursus || true
	pdflatex --interaction nonstopmode cursus.tex || true
	pdflatex --interaction nonstopmode cursus.tex || true
	make clean

clean:
	rm *.aux *.out *.log *.bbl *.blg *~ *.*~*
