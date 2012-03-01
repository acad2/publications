triplet([X,Y,Z],L) :-
	member(Z,L),
	Z \== 0,
	member(X,L),
	X \== Z,
	member(Y,L),
	X \== Y,
	Z \== Y,
	Z*(10*X+Y) =:= X*(10*Y+Z).

minimum(L) :-
	minimum(L,1).
minimum(L,N) :-
	sublists([0,1,2,3,4,5,6,7,8,9],L),
	findall(S,sum(S,L),B),
	length(B,N),
	!.
minimum(L,N) :-
	N1 is N+1,
	minimum(L,N1).
sum([T,W,O,F,U,R],L) :-
	member(T,L),
	member(W,L),
	W \== T,
	member(O,L),
	O \== T,
	O \== W,
	member(F,L),
	F \== T,
	F \== W,
	F \== O,
	member(U,L),
	U \== T,
	U \== W,
	U \== O,
	U \== F,
	member(R,L),
	R \== T,
	R \== W,
	R \== O,
	R \== F,
	R \== U,
	200*T+20*W+2*O =:= 1000*F+100*O+10*U+R.

sublists([],[]).
sublists([_|T],U) :-
	sublists(T,U).
sublists([X|T],[X|U]) :-
	sublists(T,U).
