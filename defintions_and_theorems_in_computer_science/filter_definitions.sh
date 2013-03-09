echo "Countindex:" > countindex
for f in *.gz
do
	gzip -d "$f"
	rm "$f"
done
for f in *.ps
do
	pstopdf "$f" "$f.pdf"
	rm "$f"
done
for f in *.pdf
do
	pdftotext "$f" "tmp"
	w=$(grep -E "(D|d)(efinition|efinitie) [0-9]+" "tmp" | wc -l)
	echo "Found $w!"
	if [ $w -gt 0 ]; then
		echo "Keep"
		echo "$w: $f" >> countindex
	else
		echo "Will remove this"
		rm "$f"
	fi
done
rm "tmp"
