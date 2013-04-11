mkdir -p "listings"
mkdir -p "ocrcache"
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
	perl ~/Projects/publications/publications/defintions_and_theorems_in_computer_science/definition_filter.pl < "$f.txt" > "listings/$f.txt"
done
rm "listings/tmp"
