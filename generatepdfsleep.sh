#!/bin/bash

tmo=900            #15 minutes, the maximum amount of time the compilers get per session
                   #to ensure this script will always and pdflatex won't get it in an infinite loop
tim=1              #1 second, the amount of time between two compilation sequences
pint="nonstopmode" #The interaction mode used for pdflatex

timeout $tmo pdflatex --interaction $pnt "$1.tex" || true
timeout $tmo makeglossaries -q "$1"
timeout $tmo makeindex -q "$1"
sleep $tim

timeout $tmo pdflatex --interaction $pnt "$1.tex"
timeout $tmo bibtex "$1"
timeout $tmo makeglossaries -q "$1"
timeout $tmo makeindex -q "$1"
sleep $tim

timeout $tmo pdflatex --interaction $pnt "$1.tex"
timeout $tmo bibtex "$1"
sleep $tim

timeout $tmo pdflatex --interaction $pnt "$1.tex"
sleep $tim

timeout $tmo pdflatex --interaction $pnt "$1.tex"
