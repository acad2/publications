mkdir "listings"
for f in *.pdf
do
	pdftotext "$f" "listings/tmp"
	perl ~/Projects/publications/publications/defintions_and_theorems_in_computer_science/definition_filter.pl < "listings/tmp" > "listings/$f.txt"
done
rm "listings/tmp"
