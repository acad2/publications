mkdir "listings"
for f in *.pdf
do
	pdftotext "$f" "listings/tmp"
	perl ~/pdf_workplace/definition_filter.pl < "listings/tmp" > "listings/$f.txt"
done
rm "listings/tmp"
