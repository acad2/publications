all : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	make images
	make poster.pdf
	make clean
poster.pdf : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/csd51c"
	pdflatex --shell-escape --interaction nonstopmode poster.tex >/dev/null 2>/dev/null
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
