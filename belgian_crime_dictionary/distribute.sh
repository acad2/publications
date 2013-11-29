while read p; do
	grep "\\individual{$p" < all.tex > "$p.tex"
	grep "\\evententry{$p" < all.tex >> "$p.tex"
	grep "\\caseentry{$p" < all.tex >> "$p.tex"
	grep "\\groupentry{$p" < all.tex >> "$p.tex"
	grep "\\commissieentry{$p" < all.tex >> "$p.tex"
	grep "\\operationentry{$p" < all.tex >> "$p.tex"
done < chaps
grep "\\annon{" < all.tex > "annon.tex"
