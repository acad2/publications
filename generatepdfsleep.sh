#!/bin/bash

tmo=900                 #15 minutes, the maximum amount of time the compilers get per session
                        #to ensure this script will always and pdflatex won't get it in an infinite loop
tim=1                   #1 second, the amount of time between two compilation sequences

pint="nonstopmode"      #The interaction mode used for pdflatex
popt="-file-line-error" #additional options for pdflatex

TEXINPUTS="$TEXINPUTS:../libtex//:../SharedData//"
export TEXINPUTS

timeout $tmo pdflatex $popt --interaction $pint "$1.tex" >/dev/null 2>/dev/null
timeout $tmo makeglossaries -q "$1" >dev/null 2>/dev/null
timeout $tmo makeindex -q "$1" >dev/null 2>/dev/null
sleep $tim

timeout $tmo pdflatex $popt --interaction $pint "$1.tex" >/dev/null 2>/dev/null
timeout $tmo bibtex "$1" >dev/null 2>/dev/null
timeout $tmo makeglossaries -q "$1" >dev/null 2>/dev/null
timeout $tmo makeindex -q "$1" >dev/null 2>/dev/null
sleep $tim

timeout $tmo pdflatex $popt --interaction $pint "$1.tex" >/dev/null 2>/dev/null
timeout $tmo bibtex "$1" >dev/null 2>/dev/null
sleep $tim

timeout $tmo pdflatex $popt --interaction $pint "$1.tex" >/dev/null 2>/dev/null
sleep $tim

timeout $tmo pdflatex $popt --interaction $pint "$1.tex"
