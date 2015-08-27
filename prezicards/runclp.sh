#!/bin/bash
#shd=$(dirname "${BASH_SOURCE[0]}")
if [ ! -f "locations.dat" ]
then
	sort < "model.ecl" > "/tmp/eclmod.pl"
	cd "$shd"
	#timeout "$to" 
	../libtex/preziposters-placement/eclipse/bin/x86_64_linux/eclipse -l 204800 -g 204800 -f "/tmp/eclmod.pl" -f "model.pl" -e 'solve.' > "locations.dat"
	#./eclipse/bin/x86_64_linux/eclipse
fi
