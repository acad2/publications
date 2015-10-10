full : cursus.pdf clean
cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex ../SharedData/*.sty
	date
	date > logger.dat
	date > error.dat
	bash ../generatepdfsleep.sh "cursus" >> logger.dat 2>> errors.dat #TODO: remove io redirects
	make clean
	echo "[Done]"

clean:
	rm -f *.aux *.out *.log *.bbl *.blg *~ *.*~* *.mtc* *.toc *.xdy *.glg *.glo *.gls *.glsdefs *.idx *.ind *.ist *.lof *.lot *.ilg *.maf logger.dat errors.dat
purge: clean
	rm -f cursus.pdf
