poster :
	make bar.eps
	make images
	make poster.pdf
images : *.svg Makefile *.sh
	bash makeimages.sh
poster.pdf : *.tex tikzpictures/*.tex
	bash makeposter.sh
%.pdf : %.svg Makefile processsvg.sh
	bash processsvg.sh $<
loop :
	bash makeloop.sh
bar.eps : Makefile
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/csd51c"
