#!/bin/bash
#Creates a new LaTeX table

#Parameters
pref="tikzpictures/tikz"
srcr="template"

#Check if a label is provided
if [ "$#" -le 0 ]
then
    read -p "Please provide a parameter to label the figure!" -r lbl
else
    lbl="$1"
fi

if [ "$#" -gt 1 ]
then
    srcr="$2"
fi

#Check if a table with the label already exists
if [ -f "$pref-$lbl.tex" ]
then
    echo "The figure with the label \"$lbl\" already exists!"
    exit 2
fi

#Copy the template and start the editor
cp "$pref-$srcr.tex" "$pref-$lbl.tex"
vim "$pref-$lbl.tex"
exit 0
