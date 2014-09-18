ls problems/*.tex | xargs printf "\input{%s}\n" > problems.tex
ls topics/*.tex | xargs printf "\input{%s}\n" > topics.tex
