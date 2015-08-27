poster :
	make bar.eps
	make images
	make poster.pdf
images : *.svg Makefile *.sh
	bash makeimages.sh
card-%.pdf : card-*.tex
	-bash ../libtex/scripts/makepdf.sh $<
	-bash runclp.sh
	-bash ../libtex/scripts/makepdf.sh $<
clean :
	rm -rf *.dat
%.pdf : %.svg Makefile processsvg.sh
	bash processsvg.sh $<
loop :
	bash makeloop.sh 30
bar.eps : Makefile
	qrencode -o "bar.eps" -l H -t EPS "http://goo.gl/lqAUrz"
