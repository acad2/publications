cursus.pdf: *.tex *.bib *.sty */*.tex tables/*.tex tikzpictures/*.tex
	bash ../generatepdfsleep.sh "cursus" > /dev/null 2> /dev/null
	make clean
	echo "[Done]"

clean:
	rm *.aux *.out *.log *.bbl *.blg *~ *.*~*
