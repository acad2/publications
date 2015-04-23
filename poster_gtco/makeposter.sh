#!/bin/bash
TEXINPUTS="../libtex//:$TEXINPUTS"
export TEXINPUTS

pdflatex --interaction nonstopmode "poster.tex"
pdflatex --interaction nonstopmode "poster.tex"
pdflatex --interaction nonstopmode "poster.tex"
pdflatex --interaction nonstopmode "poster.tex"
