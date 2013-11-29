:- use_module(library(clpfd)).

fourTeachersSlow([A,B,C,D]) :-
	member(A,[1,2,4,5]),   %A kiezen uit Da
	member(B,[1,2,3,4]),   %B kiezen uit Db
	DAB is abs(A-B),
	member(DAB,[1,2]),     %c(A,B) controleren
	member(C,[1,2,3]),     %C kiezen uit Dc
	1<abs(A-C),            %c(A,C) controleren
	C < B-1,               %c(B,C) controleren
	member(D,[1,2,3,4,5]), %D kiezen uit Dd
	D < A-1,               %c(A,D) controleren
	D is B-2,              %c(B,D) controleren
	D \== C.               %c(C,D) controleren

fourTeachers([A,B,C,D]) :-
	Vars = [A,B,C,D],
	Vars ins 1..5,
	A #\= 3,
	B #\= 5,
	C #=< 3,
	abs(A-B) #>= 1, abs(A-B) #=< 2,
	abs(A-C) #> 1,
	D #< A-1,
	C #< B-1,
	D #= B-2,
	C #\= D.
	label(Vars).
