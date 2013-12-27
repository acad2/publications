poster.pdf : *.tex
	pdflatex --interaction nonstopmode poster.tex >/dev/null 2>/dev/null
	make clean
upload :
	make poster.pdf || true
	scp poster.pdf ulyssis:www/posterab.pdf
clean :
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
