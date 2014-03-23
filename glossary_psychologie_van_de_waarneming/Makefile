all : *.tex Makefile
	make pvdw_glossary.pdf
	make clean
pvdw_glossary.pdf : *.tex Makefile
	make diagnostic > /dev/null 2>/dev/null
diagnostic : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh pvdw_glossary
upload : *.tex Makefile
	make all || true
	scp pvdw_glossary.pdf ulyssis:www/pvdw_glossary.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
