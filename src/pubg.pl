/*SEBUAH GAME PUBG DENGAN PROLOG*/

mulai :-
	tulis_logo,nl,nl,nl,nl,nl,
	inis_pemain,nl,
	inis_musuh,nl,
	tulis_perintah.

tulis_logo :-
	write('--------------------PUBG ITB---------------------\n').
	
tulis_perintah :-
	tab(3),write('mulai                  |mulai game'),nl,
	tab(3),write('lihat_daftar           |tampilkan daftar perintah'),nl,
	tab(3),write('keluar                 |keluar dari game'),nl,
	tab(3),write('look                   |melihat kondisi sekitar'),nl,
	tab(3),write('map                    |buka peta'),nl,
	tab(3),write('n                      |bergerak ke atas'),nl,
	tab(3),write('s                      |bergerak ke bawah'),nl,
	tab(3),write('w                      |bergerak ke kiri'),nl,
	tab(3),write('e                      |bergerak ke kanan'),nl.





/*----------------------DEFINISI STAT PLAYER AWAL DAN ENEMY----------------------*/
/* Dynamic untuk mencatat posisi player*/
:-dynamic(pemain/6).


/*maksimal tingkat kesehatan*/
maksimal_sehat(100).

/*maksimal jumlah peluru*/
maksimal_peluru(100).

/*inisialisasi atribut pemain*/
inis_sehat(100).
inis_senjata(ketapel).
inis_peluru(100).
inis_pelindung(tameng).

inis_pemain :-
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	/*catat senjata dan pelindung yang dibawa pemain pada inventori*/
	asserta(inventori(Senjata)),
	asserta(inventori(Pelinding)),	
	random(2,19,X),
	random(2,19,Y),
	write('Anda jatuh di :'),
	write(X),write(' '),write(Y),
	asserta(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),!.


/*Fakta Enemy*/
:-dynamic(musuh/7).

/*fungsi random(A,B,X) menghasilkan sebuah angka random antara A dan B*/

coba :-
	random(1,23,X),
	write(X).

list_senjata([basoka,pistol,ketapel]).
list_pelindung([tameng,helm,celana,baju]).
list_ammo(10,40,60,80,100).
list_sehat(10,40,60,80,100).
/*musuh juga bisa bergerak secara random*/
/*random senjata dan pelindung juga bisa dilakukan*/



enemy(tuyul).

choose([], []).
choose(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).

inis_musuh :-
	enemy(Jenis),
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	random(2,19,X),
	random(2,19,Y),
	write('Muncul musuh di :'),
	write(X),write(' '),write(Y),
	asserta(musuh(Jenis,X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(obj(tuyul,X,Y)),!.


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
/* obj(nama,koord.x,koord.y)   */

:-dynamic(obj/3).

/*----------------------DEFINISI MAP AWAL----------------------*/


/*RULE*/

/*===========RULE DASAR==============*/
/*GENERATE RANDOM POSISITION*/


/*===========RULE COMMAND==============*/

/*----------------------MOVE PLAYER OR ENEMY----------------------*/

/*----------------------PRINT MAP----------------------*/
/*Fungsi Gerak*/
/* masukin A bebas, gak ada pengaruh */
n :- 
	pemain(X,Y,M,N,O,P),Z is Y-1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(X,Z,M,N,O,P)),inis_musuh.
s :- 
	pemain(X,Y,M,N,O,P),Z is Y+1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(X,Z,M,N,O,P)),inis_musuh.
w :- 
	pemain(X,Y,M,N,O,P),Z is X-1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(Z,Y,M,N,O,P)),
	inis_musuh.
e :- 
	pemain(X,Y,M,N,O,P),Z is X+1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(Z,Y,M,N,O,P)),
	inis_musuh.

/*Fungsi menggambar map AxA*/
map :- pemain(X,Y,O,P,Q,R),game(20,B,20,1,X,Y),printmatrix(B).
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
lihat_sekitar :- pemain(M,N,O,P,Q,R),game(20,B,20,1,M,N),looky(20,B,C,20,M,N),cek_obj(C,D,M,N),printmatrix(D).

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

/*-------------------Inventori--------------------*/
:-dynamic(inventori/6).

/*----------------------TAKE----------------------*/
take(Objek) :-
	write(Objek),
	asserta(inventori(Objek)).
	/*tambah objek ke inventori pemain*/

/*----------------------DROP----------------------*/
drop(Objek) :-
	write(Objek),
	retract(inventori(Objek)).
	/*buang objek dari inventori pemain*/

/*----------------------USE----------------------*/

/*----------------------ATTACK (FAIL DAN GOAL STATE DI CEK DISINI)---------------------- */
/*Pemain melakukan serangan*/
/*
serang :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	Peluru_sekarang is Peluru-10,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y,Sehat,Senjata,Peluru_sekarang,Pelindung)),!.

  diserang :-
  	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
  	senjata(Senjata,Kerusakan),
  	Sehat_sekarang is Sehat - Kerusakan,
  	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
  	asserta(pemain(X,Y,Sehat_sekarang,Senjata,Peluru,Pelindung)),!.


*/

/*----------------------STATUS----------------------*/
/*cek status pemain*/
status_pemain :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	write('Koordinat posisi pemain pada ('),write(X), write(','), write(Y), write(')'),nl,
	write('Tingkat kesehatan : '),write(Sehat),nl,
	write('Senjata yang dipegang : '),write(Senjata),nl,
	write('Jumlah peluru yang tersisa : '),write(Peluru),nl,
	write('Pelindung yang dipakai : '),write(Pelindung),nl.

/*----------------------START----------------------*/
