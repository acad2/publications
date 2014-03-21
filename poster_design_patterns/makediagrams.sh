for f in UML/*.uxf
do
	g=$(basename "$f" ".uxf")
	make "$g.pdf"
done
