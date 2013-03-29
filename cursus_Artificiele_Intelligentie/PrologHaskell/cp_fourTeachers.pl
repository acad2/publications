:- use_module(library(clpfd)).        %laad de constraint processing module in

fourTeachers([A,B,C,D]) :-
    Vars = [A,B,C,D],                 %variabelen initialiseren
    Vars ins 1..5,                    %domein specifieren
    A #\= 3,                          %c(A)
    B #\= 5,                          %c(B)
    C #=< 3,                          %c(C)
    abs(A-B) #>= 1, abs(A-B) #=< 2,   %c(A,B)
    abs(A-C) #> 1,                    %c(A,C)
    D #< A-1,                         %c(A,D)
    C #< B-1,                         %c(B,C)
    D #= B-2,                         %c(B,D)
    C #\= D,                          %c(C,D)
    label(Vars).                      %los het constraint probleem op.

fourTeachersNoLabel([A,B,C,D]) :-
    Vars = [A,B,C,D],                 %variabelen initialiseren
    Vars ins 1..5,                    %domein specifieren
    A #\= 3,                          %c(A)
    B #\= 5,                          %c(B)
    C #=< 3,                          %c(C)
    abs(A-B) #>= 1, abs(A-B) #=< 2,   %c(A,B)
    abs(A-C) #> 1,                    %c(A,C)
    D #< A-1,                         %c(A,D)
    C #< B-1,                         %c(B,C)
    D #= B-2,                         %c(B,D)
    C #\= D.                          %c(C,D)
