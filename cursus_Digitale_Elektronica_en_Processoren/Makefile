cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex ../SharedData/*.sty
	bash ../generatepdfsleep.sh "cursus" > logger.dat 2> errors.dat #TODO: remove io redirects
	make clean
	echo "[Done]"

clean:
	rm *.aux *.out *.log *.bbl *.blg *~ *.*~* *.mtc*
