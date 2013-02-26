#!/bin/bash
echo "" > "alldefs"
for f in define.php\?term\=*
do
	perl "filterdefinitions.pl" < "$f" >> "alldefs"
done
