#!/bin/bash
#Creates a new LaTeX table

#Parameters
pref="tables/tbl-"

#Check if a label is provided
if [ "$#" -le 0 ]
then
    echo "Please provide a parameter to label the table!"
    exit 1
fi

#Check if a table with the label already exists
if [ -f "$pref$1.tex" ]
then
    echo "The table with the label \"$1\" already exists!"
    exit 2
fi

#Copy the template and start the editor
cp "tbl/tbl-template.tex" "tbl/tbl-$1.tex"
vim "tbl/tbl-$1.tex"
exit 0
