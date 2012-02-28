cd "`dirname $0`"
echo "Execute commit"
git add *
git commit -m "Nieuwe toestand van het project"
git push
echo "[Done]"
