all : *.tex Makefile
	make dictionary.pdf
	make clean
dictionary.pdf : *.tex Makefile
	make diagnostic > /dev/null 2>/dev/null
diagnostic : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh dictionary
upload : *.tex Makefile
	make all || true
	scp dictionary.pdf ulyssis:www/copdic.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup > /dev/null 2> /dev/null || true
