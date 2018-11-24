/*SEBUAH GAME PUBG DENGAN PROLOG*/

/*DEFINISI STAT PLAYER AWAL DAN ENEMY*/





/*DEFINISI WEAPON DAN AMMO*/

/*weapon(NAMA,DAMAGE)*/
weapon(ak47,20).
weapon(m4a1,15).
/*ammo(NAMA,MAGSIZE)*/
ammo(aka47,20).
ammo(m4a1,15).

/*DEFINISI MEDICINE*/
/*medic(NAMA,HEAL)*/
medic(pill,10).
medic(plester,20).

/*DEFINISI ARMOR*/
/*armor(NAMA,DEFEND)*/
armor(helm,2).
armor(kevlar,5).

/**/


/*DEFINISI MAP AWAL*/


/*RULE*/

/*===========RULE DASAR==============*/
/*GENERATE RANDOM POSISITION*/


/*===========RULE COMMAND==============*/

/*MOVE PLAYER OR ENEMY*/

/*PRINT MAP*/
/*Fungsi Gerak*/
n(A) :- pemain(X,Y),Z is Y-1,retract(pemain(X,Y)),asserta(pemain(X,Z)).
s(A) :- pemain(X,Y),Z is Y+1,retract(pemain(X,Y)),asserta(pemain(X,Z)).
w(A) :- pemain(X,Y),Z is X-1,retract(pemain(X,Y)),asserta(pemain(Z,Y)).
e(A) :- pemain(X,Y),Z is X+1,retract(pemain(X,Y)),asserta(pemain(Z,Y)).

/*Fungsi menggambar map AxA*/
map(A) :- pemain(X,Y),game(A,B,A,1,X,Y),printmatrix(B).
/*
param1 nilai sama dengan param3 (utk iterasi)
param2 hasil matriks
param3 luas lapangan
param4 lebar deadzone
param5 koordinat x player
param6 koordinat y player
*/

wall(0,[]):- !.
wall(A,['x '|B]):- C is A-1, wall(C,B).
printwall(A) :- wall(A,B),printlist(B),nl.

side(0,[],M,T):- !.
side(A,['x '|B],M,T):- N is M-T,A > N,!,C is A-1,side(C,B,M,T).
side(A,['x '|B],M,T):- A =< T,!,C is A-1,side(C,B,M,T).
side(A,['- '|B],M,T):- C is A-1,side(C,B,M,T).

sidep(0,[],M,T,X):- !.
sidep(A,['p '|B],M,T,X):- A=:=X,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,['x '|B],M,T,X):- N is M-T,A > N,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,['x '|B],M,T,X):- A =< T,!,C is A-1,sidep(C,B,M,T,X).
sidep(A,['- '|B],M,T,X):- C is A-1,sidep(C,B,M,T,X).

game(0,[],M,T,X,Y):- !.
game(A,[C|B],M,T,X,Y) :- N is M-T,A > N,!,wall(M,C),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- A=<T,!,wall(M,C),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- A=:=Y,!,sidep(M,C,M,T,X),D is A-1,game(D,B,M,T,X,Y).
game(A,[C|B],M,T,X,Y) :- side(M,C,M,T),D is A-1,game(D,B,M,T,X,Y).

/*INCREASE DEADZONE*/
/* Perlu catat waktu*/

/*LOOK*/
look(X,Y) :- game(10,B,10,1,X,Y),looky(10,B,C,10,X,Y),printmatrix(C).

looky(A,[D|B],[C|[]],M,X,Y) :- Z is Y-1,A =:= Z,!,lookx(M,D,C,M,X).
looky(A,[D|B],[C|F],M,X,Y):- A=:=Y,!,lookx(M,D,C,M,X),E is A-1,looky(E,B,F,M,X,Y).
looky(A,[D|B],[C|F],M,X,Y) :- Z is Y+1,A =:= Z,!,lookx(M,D,C,M,X),E is A-1,looky(E,B,F,M,X,Y).
looky(A,[D|B],C,M,X,Y) :- E is A-1,looky(E,B,C,M,X,Y).

lookx(A,[D|B],[D|[]],M,X):- Z is X-1,A =:= Z,!.
lookx(A,[D|B],[D|C],M,X):- A=:=X,!,E is A-1,lookx(E,B,C,M,X).
lookx(A,[D|B],[D|C],M,X):- Z is X+1,A =:= Z,!,E is A-1,lookx(E,B,C,M,X).
lookx(A,[D|B],C,M,X):- E is A-1,lookx(E,B,C,M,X).

/*TAKE*/

/*DROP*/

/*USE*/

/*ATTACK*/(FAIL DAN GOAL STATE DI CEK DISINI)

/*STATUS*/

/*START*/
