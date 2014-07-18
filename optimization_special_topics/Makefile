book.pdf : *.tex *.bib */*.tex
	bash makepdf.sh nonstopmode book.tex

quiet : *.tex *.bib */*.tex
	make book.pdf >/dev/null 2>/dev/null
