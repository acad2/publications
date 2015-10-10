#!/bin/bash
tim=$(date +%s)
gla=$(grep -c '\\gls@defglossaryentry' cursus.glsdefs)
err=$(grep -c '^\./[^:]*:[0-9]*:' logger.dat)
wrn=$(grep -c '^LaTeX Warning' logger.dat)
msl=$(bash 'find-broken-ref.sh' | wc -l)
echo -e "$tim\t$err\t$wrn\t$msl\t$gla"
