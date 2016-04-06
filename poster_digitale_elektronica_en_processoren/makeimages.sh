for f in *.svg
do
	g=$(basename "$f" ".svg")
	make "$g.pdf"
done
