#!/bin/bash
#Creates a new LaTeX table

#Parameters
pref="tables/tbl-"

#Check if a label is provided
if [ "$#" -le 0 ]
then
    read -p "Please provide a parameter to label the table!" -r lbl
else
    lbl="$1"
fi

#Check if a table with the label already exists
if [ -f "$pref$lbl.tex" ]
then
    echo "The table with the label \"$lbl\" already exists!"
    exit 2
fi

#Copy the template and start the editor
cp "tbl/tbl-template.tex" "tbl/tbl-$lbl.tex"
vim "tbl/tbl-$lbl.tex"
exit 0
