man(marcus).
pompeier(marcus).
romein(X) :- pompeier(X).
heerser(cesar).

loyaalAan(X,loyaal(X)).
:- mens(X), heerser(Y), probeerTeVermoorden(X,Y), loyaalAan(X,Y).
probeerTeVermoorden(marcus,cesar).
mens(X) :- man(X).
