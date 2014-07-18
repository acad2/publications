all : *.tex Makefile
	make poster.pdf
	make clean
poster.pdf : *.tex Makefile
	make diagnostic > /dev/null 2>/dev/null
diagnostic : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh poster
upload : *.tex Makefile
	make all || true
	scp pvdw_glossary.pdf ulyssis:www/postercn.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup > /dev/null 2> /dev/null || true
