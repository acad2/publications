all : *.tex UML/*.uxf Makefile
	make diagrams
	make poster.pdf
	make clean
poster.pdf : *.tex UML/*.uxf Makefile
	pdflatex --shell-escape --interaction nonstopmode poster.tex >/dev/null 2>/dev/null
diagnostic : *.tex UML/*.uxf Makefile
	pdflatex --shell-escape poster.tex
diagrams :  UML/*.uxf Makefile
	bash makediagrams.sh
upload : *.tex Makefile ../SharedData/*.sty *.svg *.sh
	make all || true
	scp poster.pdf ulyssis:www/posterdesignpatterns.pdf
clean : *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup
	rm -f *.aux *.log *.bbl *.bak *.blg *.toc *.out *.glg *.glo *.gls *.ist *~ *.*~* *.backup

%.pdf : UML/%.uxf Makefile *.sh
	bash processuxf.sh $<
