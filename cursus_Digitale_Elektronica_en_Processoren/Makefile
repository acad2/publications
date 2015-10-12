full : cursus.pdf clean
cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex ../SharedData/*.sty
	date
	date > logger.dat
	date > errors.dat
	bash ../generatepdfsleep.sh "cursus" >> logger.dat 2>> errors.dat
	echo "[Done]"

clean:
	rm -f *.aux *.out *.log *.bbl *.blg *~ *.*~* *.mtc* *.toc *.xdy *.glg *.glo *.gls *.glsdefs *.idx *.ind *.ist *.lof *.lot *.ilg *.maf logger.dat errors.dat
purge: clean
	rm -f cursus.pdf
