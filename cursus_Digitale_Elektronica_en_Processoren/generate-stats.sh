#!/bin/bash

lgf="old-logger.dat"

tim=$(date +%s)
gla=$(grep -c '\\gls@defglossaryentry' cursus.glsdefs)
err=$(grep -c '^\./[^:]*:[0-9]*:' $lgf)
wrn=$(grep -c '^LaTeX Warning' $lgf)
msl=$(bash 'find-broken-ref.sh' | wc -l)
echo -e "$tim\t$err\t$wrn\t$msl\t$gla"
