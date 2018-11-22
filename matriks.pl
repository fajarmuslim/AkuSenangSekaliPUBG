
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

/*Fungsi print matrix*/
printmatrix([]) :- !.
printmatrix([A|B]):- printmatrix(B),printlist(A),nl.

/*Fungsi Print List*/
printlist([]) :- !.
printlist([A|B]) :- printlist(B),print(A).

/*----------------Fungsi Wall Generator--------------------*/

/*Tembok atas & bawah*/
wall(0,[]):- !.
wall(A,[x|B]):- C is A-1, wall(C,B).
printwall(A) :- wall(A,B),printlist(B),nl.

/*Fungsi menggambar map AxA*/
printgame(A) :- game(A,B,A,4,6,3),printmatrix(B).
/*
param1 nilai sama dengan param3 (utk iterasi)
param2 hasil matriks
param3 luas lapangan
param4 lebar deadzone
param5 koordinat x player
param6 koordinat y player
*/

side(0,[],M,T):- !.
side(A,[x|B],M,T):- N is M-T,A > N,!,C is A-1,side(C,B,M,T).
side(A,[x|B],M,T):- A =< T,!,C is A-1,side(C,B,M,T).
side(A,[-|B],M,T):- C is A-1,side(C,B,M,T).
/*Menaruh Player*/
sidep(0,[],M,T,X):- !.
sidep(A,[p|B],M,T,X):- A=:=X,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,[x|B],M,T,X):- N is M-T,A > N,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,[x|B],M,T,X):- A =< T,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,[-|B],M,T,X):- C is A-1,sidep(C,B,M,T,X).


game(0,[],M,T,X,Y):- !.
game(A,[C|B],M,T,X,Y) :- N is M-T,A > N,!,wall(M,C),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- A=<T,!,wall(M,C),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- A=:=Y,!,sidep(M,C,M,T,X),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- side(M,C,M,T),D is A-1,game(D,B,M,T,X,Y).
