all : *.tex Makefile
	make samenvattingAI.pdf
	make clean
samenvattingAI.pdf : *.tex Makefile
	bash ../bash_scripts/generatepdf.sh samenvattingAI
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup *.ilg *.idx *.ind
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup *.ilg *.idx *.ind
