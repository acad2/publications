bnm=$(basename "$1" ".pdf")
bnm=$(basename "$bnm" ".tex")
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
makeglossaries -q "$bnm" || true
makeindex -q "$bnm" || true
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
bibtex "$bnm" || true
makeglossaries -q "$bnm" || true
makeindex -q "$bnm" || true
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
bibtex "$bnm" || true
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
pdflatex --shell-escape --interaction nonstopmode "$bnm.tex" || true
