all : *.tex Makefile
	make samenvattingTMI.pdf
	make clean
samenvattingTMI.pdf : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh samenvattingTMI
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup *.ilg *.idx *.ind
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup *.ilg *.idx *.ind
