timeout 600 pdflatex --interaction nonstopmode "$1.tex" || true
timeout 600 makeglossaries -q "$1"
timeout 600 makeindex -q "$1"
sleep 1
timeout 600 pdflatex --interaction nonstopmode "$1.tex"
timeout 600 bibtex "$1"
timeout 600 makeglossaries -q "$1"
timeout 600 makeindex -q "$1"
sleep 1
timeout 600 pdflatex --interaction nonstopmode "$1.tex"
timeout 600 bibtex "$1"
sleep 1
timeout 600 pdflatex --interaction nonstopmode "$1.tex"
sleep 1
timeout 600 pdflatex --interaction nonstopmode "$1.tex"
