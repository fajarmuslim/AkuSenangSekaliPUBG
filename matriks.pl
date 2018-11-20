
/*
    Contoh input : list_to_matrix([a,b,c,d],2,X).
    X = [[a,b],[c,d]]
 */


list_to_matrix([],_, []).
list_to_matrix(List, Size, [Row|Matrix]):-
  list_to_matrix_row(List, Size, Row, Tail),
  list_to_matrix(Tail, Size, Matrix).

list_to_matrix_row(Tail, 0, [], Tail).
list_to_matrix_row([Item|List], Size, [Item|Row], Tail):-
  NSize is Size-1,
  list_to_matrix_row(List, NSize, Row, Tail).

/*Fungsi append*/
mappend([], X, X) :- !.
mappend([A|B],C,[A|D]) :- mappend(B, C, D).

/*Fungsi print matrix*/
printmatrix([]) :- !.
printmatrix([A|B]):- printlist(A),nl,printmatrix(B).

/*Fungsi Print List*/
printlist([]) :- !.
printlist([A|B]) :- print(A),printlist(B).

/*Fungsi Wall Generator*/
wall(0,[]):- !.
wall(A,[x|B]):- C is A-1, wall(C,B).
printwall(A) :- wall(A,B),printlist(B),nl.

sidewall(0,[x|[]]):- !.
sidewall(A,[x|B]) :- C is A-2, arena(C,B).

arena(0,B):- sidewall(0,B).
arena(A,[-|B]):- C is A-1, arena(C,B).
printarena(A) :- sidewall(A,B),printlist(B),nl.

printgame(A) :- printwall(A),C is A-2,printmid(C,A).

printmid(A,B):- A =:=0,!,printwall(B),!.
printmid(A,B):- A > 0,!,printarena(B),C is A-1,printmid(C,B).
