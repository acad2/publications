#!/bin/sh
cd "`dirname $0`"
echo "Execute commit"
git add -u
git add *
git rm -r *~
git clean -f
git gc --aggressive --no-prune
if [ $# -eq 0 ]
then
	git commit -m "Nieuwe toestand van het project"
else
	git commit -m "$1"
fi
git push
echo "[Done]"
