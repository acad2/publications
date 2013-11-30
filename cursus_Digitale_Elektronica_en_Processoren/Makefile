cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex
	pdflatex --interaction nonstopmode cursus.tex || true
	makeglossaries cursus || true
	makeindex cursus || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex || true
	bibtex cursus || true
	makeglossaries cursus || true
	makeindex cursus || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex || true
	bibtex cursus || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex || true
	make clean

clean:
	rm *.aux *.out *.log *.bbl *.blg *~ *.*~*
