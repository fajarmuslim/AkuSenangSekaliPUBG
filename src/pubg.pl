/*SEBUAH GAME PUBG DENGAN PROLOG*/

/*----------------------DEFINISI STAT PLAYER AWAL DAN ENEMY----------------------*/
/* Dynamic untuk mencatat posisi player*/
:-dynamic(pemain/2).

/*Fakta Enemy*/
enemy(tuyul).

/*----------------------DEFINISI WEAPON DAN AMMO----------------------*/

/*Fakta Weapon*/
weapon(ak47).
weapon(m4a1).

/* Fakta Ammo*/
ammo(ammo_ak47).
ammo(ammo_m4a1).

/*weapon(NAMA,DAMAGE)*/
damage(ak47,20).
damage(m4a1,15).
/*ammo(NAMA,MAGSIZE)*/
magsize(ak47,20).
magsize(m4a1,15).

/*----------------------DEFINISI MEDICINE----------------------*/

/*Fakta Medic*/
medic(pill).
medic(plester).

/*medic(NAMA,HEAL)*/
heal(pill,10).
heal(plester,20).

/*----------------------DEFINISI ARMOR----------------------*/

/*Fakta Armor*/
armor(helm).
armor(kevlar).

/*armor(NAMA,DEFEND)*/
defense(helm,2).
defense(kevlar,5).

/*----------------------DEFINISI OBJEK----------------------*/
/* Segala sesuatu yang ada di lapangan */
/* obj(nama,koord.x,koord.y)  :-dynamic(obj/3). */

obj(ak47,5,5).
obj(helm,5,5).

/*----------------------DEFINISI MAP AWAL----------------------*/


/*RULE*/

/*===========RULE DASAR==============*/
/*GENERATE RANDOM POSISITION*/


/*===========RULE COMMAND==============*/

/*----------------------MOVE PLAYER OR ENEMY----------------------*/

/*----------------------PRINT MAP----------------------*/
/*Fungsi Gerak*/
/* masukin A bebas, gak ada pengaruh */
n(A) :- pemain(X,Y),Z is Y-1,retract(pemain(X,Y)),asserta(pemain(X,Z)).
s(A) :- pemain(X,Y),Z is Y+1,retract(pemain(X,Y)),asserta(pemain(X,Z)).
w(A) :- pemain(X,Y),Z is X-1,retract(pemain(X,Y)),asserta(pemain(Z,Y)).
e(A) :- pemain(X,Y),Z is X+1,retract(pemain(X,Y)),asserta(pemain(Z,Y)).

/*Fungsi menggambar map AxA*/
map(A) :- pemain(X,Y),game(A,B,A,1,X,Y),printmatrix(B).
/*
utk game :
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

/*Fungsi print matrix*/
printmatrix([]) :- !.
printmatrix([A|B]):- printmatrix(B),printlist(A),nl.

/*Fungsi Print List*/
printlist([]) :- !.
printlist([A|B]) :- printlist(B),print(A).

/*----------------------INCREASE DEADZONE----------------------*/
/* Perlu catat waktu*/

/*----------------------LOOK----------------------*/

/* Fungsi Look Utama*/
/* look dengan pusat X,Y*/
look(X,Y) :- pemain(M,N),game(10,B,10,1,M,N),looky(10,B,C,10,X,Y),cek_obj(C,D,X,Y),printmatrix(D).

looky(A,[D|B],[C|[]],M,X,Y) :- Z is Y-1,A =:= Z,!,lookx(M,D,C,M,X).
looky(A,[D|B],[C|F],M,X,Y):- A=:=Y,!,lookx(M,D,C,M,X),E is A-1,looky(E,B,F,M,X,Y).
looky(A,[D|B],[C|F],M,X,Y) :- Z is Y+1,A =:= Z,!,lookx(M,D,C,M,X),E is A-1,looky(E,B,F,M,X,Y).
looky(A,[D|B],C,M,X,Y) :- E is A-1,looky(E,B,C,M,X,Y).

lookx(A,[D|B],[D|[]],M,X):- Z is X-1,A =:= Z,!.
lookx(A,[D|B],[D|C],M,X):- A=:=X,!,E is A-1,lookx(E,B,C,M,X).
lookx(A,[D|B],[D|C],M,X):- Z is X+1,A =:= Z,!,E is A-1,lookx(E,B,C,M,X).
lookx(A,[D|B],C,M,X):- E is A-1,lookx(E,B,C,M,X).

/* Mengecek objek di lokasi look*/
cek_obj(A,B,X,Y):- V is X+1,W is Y+1,cek_objy(A,B,V,W).

cek_objy([],[],X,Y):- !.
cek_objy([A|B],[D|E],X,Y):- cek_objx(A,D,X,Y),W is Y-1,cek_objy(B,E,X,W).

cek_objx([],[],X,Y):- !.
cek_objx([A|B],[Z|D],X,Y):- priority(X,Y,Z),!,V is X-1,cek_objx(B,D,V,Y).
cek_objx([A|B],[A|D],X,Y):- V is X-1,cek_objx(B,D,V,Y).

/* Mengecek prioritas objek*/
/*Enemy > Medicine > Weapon > Armor > Ammo > pemain*/

priority(X,Y,'e ') :- obj(E,X,Y),enemy(E),!.
priority(X,Y,'m ') :- obj(M,X,Y),medic(M),!.
priority(X,Y,'w ') :- obj(W,X,Y),weapon(W),!.
priority(X,Y,'r ') :- obj(R,X,Y),armor(R),!.
priority(X,Y,'a ') :- obj(A,X,Y),ammo(A),!.

/*----------------------TAKE----------------------*/

/*----------------------DROP----------------------*/

/*----------------------USE----------------------*/

/*----------------------ATTACK (FAIL DAN GOAL STATE DI CEK DISINI)---------------------- */

/*----------------------STATUS----------------------*/

/*----------------------START----------------------*/
