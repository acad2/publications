cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex
	pdflatex --interaction nonstopmode cursus.tex > /dev/null || true
	makeglossaries -q cursus > /dev/null || true
	makeindex -q cursus > /dev/null || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex > /dev/null || true
	bibtex cursus > /dev/null || true
	makeglossaries -q cursus > /dev/null || true
	makeindex -q cursus > /dev/null || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex > /dev/null || true
	bibtex cursus > /dev/null || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex > /dev/null || true
	sleep 1
	pdflatex --interaction nonstopmode cursus.tex > /dev/null || true
	make clean

clean:
	rm *.aux *.out *.log *.bbl *.blg *~ *.*~*
