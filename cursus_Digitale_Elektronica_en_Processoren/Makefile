full : cursus.pdf clean

cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex ../libtex/*.sty
	date
	bash ../generatepdfsleep.sh "cursus"

clean:
	rm -f *.aux *.out *.log *.bbl *.blg *~ *.*~* *.mtc* *.toc *.xdy *.glg *.glo *.gls *.glsdefs *.idx *.ind *.ist *.lof *.lot *.ilg *.maf logger.dat errors.dat *.swn *.swo *.swp *.sw?

purge: clean
	rm -f cursus.pdf
