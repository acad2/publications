pdflatex --interaction nonstopmode "$1.tex" || true
makeglossaries -q "$1"
makeindex -q "$1"
sleep 1
pdflatex --interaction nonstopmode "$1.tex"
bibtex "$1"
makeglossaries -q "$1"
makeindex -q "$1"
sleep 1
pdflatex --interaction nonstopmode "$1.tex"
bibtex "$1"
sleep 1
pdflatex --interaction nonstopmode "$1.tex"
sleep 1
pdflatex --interaction nonstopmode "$1.tex"
