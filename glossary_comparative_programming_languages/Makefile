all : *.tex Makefile
	make glossary.pdf
	make clean
glossary.pdf : *.tex Makefile
	make diagnostic > /dev/null 2>/dev/null
diagnostic : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh glossary
upload : *.tex Makefile
	make all || true
	scp pvdw_glossary.pdf ulyssis:www/cpl_glossary.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup > /dev/null 2> /dev/null || true
