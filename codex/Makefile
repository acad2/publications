all : *.tex
	make diagnostic > /dev/null 2> /dev/null

diagnostic : *.tex
	pdflatex --interaction nonstopmode codex.tex
	songidx titleidx.sxd titleidx.sbx
	pdflatex --interaction nonstopmode codex.tex
	songidx titleidx.sxd titleidx.sbx
	pdflatex --interaction nonstopmode codex.tex
