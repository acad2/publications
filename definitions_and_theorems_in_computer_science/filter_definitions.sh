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
	if [ ! -f "$f.txt" ];
	then
		pdftotext "$f" "listings/tmp2"
		pdfimages -q "$f" ocrcache/page
		cd ocrcache
		for i in page*
		do
		  echo doing OCR on page $i
		  tesseract "$i" tesseract-$i -l eng
		  rm "$i"
		done
		cat *.txt > "alltext"
		rm *.txt
		cd ..
		cat "listings/tmp2" "ocrcache/alltext" > "$f.txt"
	fi
	w=$(grep -E "(D|d)(efinition|efinitie) [0-9]+" "$f.txt" | wc -l)
	echo "Found $w!"
	if [ $w -gt 0 ]; then
		echo "Keep"
		echo "$w: $f" >> countindex
	else
		echo "Will remove this"
		rm "$f"
		rm "$f.txt"
	fi
done
rm "tmp"
