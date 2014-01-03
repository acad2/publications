all : *.svg
	bash makeimages.sh
	make poster.pdf
poster.pdf : *.tex Makefile ../SharedData/*.sty *.svg
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/csd51c"
	pdflatex --shell-escape --interaction nonstopmode poster.tex >/dev/null 2>/dev/null
	make clean
upload :
	make poster.pdf || true
	scp poster.pdf ulyssis:www/posterab.pdf
clean :
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup

%.pdf : %.svg Makefile *.sh
	bash processsvg.sh $<
	
