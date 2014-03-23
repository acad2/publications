all : *.tex Makefile pvdw_ch?_glossary
	make pvdw_glossary.pdf
	make clean
pvdw_glossary.pdf : *.tex Makefile pvdw_ch?_glossary
	make diagnostic > /dev/null 2>/dev/null
diagnostic : *.tex Makefile pvdw_ch?_glossary
	cat pvdw_ch?_glossary | sed -r 's#^([^/]+)/(.*)#\\glo{\1}{\2}#g' | sort | uniq > pvdwall.tex
	bash ../bash_scripts/generatepdf.sh pvdw_glossary
	rm pvdwall.tex
upload : *.tex Makefile pvdw_ch?_glossary
	make all || true
	scp pvdw_glossary.pdf ulyssis:www/pvdw_glossary.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup > /dev/null 2> /dev/null || true
