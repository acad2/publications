#!/bin/bash

lgf="old-logger.dat"
erf="old-errors.dat"

tim=$(date +%s)
gla=$(grep -c '\\gls@defglossaryentry' cursus.glsdefs)
err=$(grep -c '^\./[^:]*:[0-9]*:' $lgf)
wrn=$(grep -c '^LaTeX Warning' $lgf)
msl=$(bash 'find-broken-ref.sh' | wc -l)

prd=$(grep -m 1 -i '^user' $erf | grep -o -P '\d+m\d+.\d+')
prdm=$(echo "$prd" | cut -d m -f 1)
prds=$(echo "$prd" | cut -d m -f 2)
prd=$(calc -p "60*$prdm+$prds")

fls=$(grep -m 1 -i '^filesize' $erf | grep -o -P '\d*')

pgs=$(grep -m 1 -i 'pages' old-errors.dat | grep -P '\d*' -o)

echo >&2 -e "timestamp\t#errors\t#warnings\t#references\t#glos\tcompile-time\tfilesize\tpages"
echo -e "$tim\t$err\t$wrn\t$msl\t$gla\t$prd\t$fls\t$pgs"
