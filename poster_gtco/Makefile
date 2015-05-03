poster :
	make bar.eps
	make images
	make poster.pdf
images : *.svg Makefile *.sh
	bash makeimages.sh
poster.pdf : *.tex tikzpictures/*.tex algorithms/*.tex ../libtex/**.cls
	bash makeposter.sh
%.pdf : %.svg Makefile processsvg.sh
	bash processsvg.sh $<
loop :
	bash makeloop.sh
bar.eps : Makefile
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/lqAUrz"
