bnm=$(basename "$1" ".pdf")
bnm=$(basename "$bnm" ".tex")
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
makeglossaries -q "$bnm"
makeindex -q "$bnm"
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex"
bibtex "$bnm"
makeglossaries -q "$bnm"
makeindex -q "$bnm"
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex"
bibtex "$bnm"
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex"
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex"
