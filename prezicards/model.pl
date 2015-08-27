% == IMPORTS ==

:- lib(ic).
:- lib(branch_and_bound).
:- lib(listut).
:- lib(ic_global).

rectangles(r(I,X,Y,CW,CH)) :-
    dimns(DW,DH),
    size(I,W,H),
    \+pos(I,_,_),
    DWW is floor(DW-W),
    DHH is floor(DH-H),
    [X] :: 2 .. DWW,
    [Y] :: 2 .. DHH,
    CW is integer(ceiling(W)),
    CH is integer(ceiling(H)).
rectangles(r(I,FX,FY,CW,CH)) :-
    size(I,W,H),
    CW is integer(ceiling(W)),
    CH is integer(ceiling(H)),
    size(I,W,H),
    pos(I,X,Y),
    FX is integer(floor(X)),
    FY is integer(floor(Y)).

nonoverlaps([H|T]) :-
    nonoverlaps(H,T),
    nonoverlaps(T).
nonoverlaps([]).

nonoverlaps(r(_,XA,YA,WA,HA),[r(_,XB,YB,WB,HB)|T]) :-
    XA+WA #< XB or XB+WB #< XA or YA+HA #< YB or YB+HB #< YA,
    nonoverlaps(r(_,XA,YA,WA,HA),T).
nonoverlaps(_,[]).


solve :-
    findall(R,rectangles(R),Rs),
    nonoverlaps(Rs),
    foldrec(Rs,Fs),
    shuffle(Fs,SFs),
    search(SFs,0,input_order,indomain_split,complete,[]),
    writerectangles(Rs).

foldrec([r(_,X,Y,_,_)|T],[X,Y|TF]) :-
    foldrec(T,TF).
foldrec([],[]).

writerectangles([R|T]) :-
    writerectangle(R),
    writerectangles(T).
writerectangles([]).

shuffle(L,LS) :-
    length(L,N),
    shuffle(L,N,LS).

shuffle([],_,[]).
shuffle(L,N,[H|ST]) :-
    I is random mod N,
    outject(L,I,H,LH),
    N1 is N-1,
    shuffle(LH,N1,ST).

outject([H|T],0,H,T) :-
    !.
outject([H|T],N,OH,[H|OT]) :-
    N1 is N-1,
    outject(T,N1,OH,OT).

writerectangle(r(I,X,Y,_,_)) :-
    write('\\csdef{xitem'),write(I),write('}{'),write(X),write('}\n'),
    write('\\csdef{yitem'),write(I),write('}{'),write(Y),write('}\n').
%    write('\\ifglsentryexists{item'),write(I),write('}{}%\n{%\\gls@defglossaryentry{item'),write(I),write('}%\n{%\nname={poem},%\nsort={poem},%\ntype={main},%\nirst={poem},%\nfirstplural={poems},%\ntext={poem},%\n%plural={poems},%\ndescription={poem},%\ndescriptionplural={poem},%\nsymbol={\\relax },%\nsymbolplural={\\relax },%\nuser1={'),
%    write(X),
%    write('},%\nuser2={'),
%    write(Y),
%    write('},%\nuser3={},%\nuser4={},%\nuser5={},%\nuser6={},%\nlong={},%\nlongplural={},%\nshort={},%\nshortplural={},%\ncounter={page},%\nparent={},%\n%\n}%\n}%\n').
