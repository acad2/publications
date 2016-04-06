all : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	make images
	make poster.pdf
	make clean
poster.pdf : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/??"
	bash ../generatepdfsleep.sh "poster"
diagnostic :
	pdflatex --shell-escape poster.tex
images : *.svg Makefile *.sh
	bash makeimages.sh
upload : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	make all || true
	scp poster.pdf ulyssis:www/posterab.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup

%.pdf : %.svg Makefile *.sh
	bash processsvg.sh $<
