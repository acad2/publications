poster :
	make bar.eps
	make poster.pdf
poster.pdf : *.tex tikzpictures/*.tex
	bash makeposter.sh
loop :
	bash makeloop.sh
bar.eps : Makefile
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/csd51c"
