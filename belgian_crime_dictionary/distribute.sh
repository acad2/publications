while read p; do
	grep "\\individual{$p" < all.tex > "$p.texp"
	grep "\\evententry{$p" < all.tex >> "$p.texp"
	grep "\\caseentry{$p" < all.tex >> "$p.texp"
	grep "\\groupentry{$p" < all.tex >> "$p.texp"
	grep "\\commissieentry{$p" < all.tex >> "$p.texp"
	grep "\\operationentry{$p" < all.tex >> "$p.texp"
done < chaps
grep "\\annon{" < all.tex > "annon.texp"
