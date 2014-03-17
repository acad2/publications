all : *.tex Makefile ../SharedData/*.sty ../SharedData/*.cls
	make poster.pdf
	make clean
poster.pdf : *.tex Makefile ../SharedData/*.sty ../SharedData/*.cls
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/iIltNY"
	pdflatex --shell-escape --interaction nonstopmode poster.tex
diagnostic :
	pdflatex --shell-escape poster.tex
upload : *.tex Makefile ../SharedData/*.sty
	make all || true
	scp poster.pdf ulyssis:www/posterfocs.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
