/*SEBUAH GAME PUBG DENGAN PROLOG*/

mulai :-
	tulis_logo,nl,
	tulis_kalimatpembuka,nl,
	asserta(jumlahmusuh(0)),
	asserta(deadzoneCounter(0,1)),
	asserta(inventori([])),
	inis_musuh(tuyul),nl,
	inis_musuh(ular),nl,
	inis_musuh(polisi),nl,
	createObjek,inis_pemain.

tulis_perintah :-
	lihat_perintah.

tulis_logo :-
	write('------------------------------PUBG ITB-----------------------------\n').

tulis_kalimatpembuka :-
	write('                    Selamat datang di game PUBG'),nl,
	write('            Misi kamu adalah menjadi last man standing'),nl,
	write('                        Bunuh musuh-musuhmu'),nl,
	write('                       Jadilah yang terbaik'),nl,nl,
	write('                          by : Mahasiswa'),nl.

lihat_perintah :-
	tab(3),write('-----------------Daftar Perintah----------------'),nl,
	tab(3),write('mulai                  |mulai game'),nl,
	tab(3),write('lihat_perintah         |tampilkan daftar perintah'),nl,
	tab(3),write('keluar                 |keluar dari game'),nl,
	tab(3),write('look                   |melihat kondisi sekitar'),nl,
	tab(3),write('map                    |buka peta'),nl,
	tab(3),write('take                   |ambil item'),nl,
	tab(3),write('drop(A)                |buang item'),nl,
	tab(3),write('useitem                |pakai item'),nl,
	tab(3),write('n                      |bergerak ke atas'),nl,
	tab(3),write('s                      |bergerak ke bawah'),nl,
	tab(3),write('w                      |bergerak ke kiri'),nl,
	tab(3),write('e                      |bergerak ke kanan'),nl.



/*----------------------DEFINISI TRIGGER DEADZONE----------------------*/
:-dynamic(deadzoneCounter/2).

deadzone:- deadzoneCounter(A,B),C is A+1,C =:= 10,!,D is B+1,retract(deadzoneCounter(A,B)),asserta(deadzoneCounter(C,D)).
deadzone:- deadzoneCounter(A,B),C is A+1,retract(deadzoneCounter(A,B)),asserta(deadzoneCounter(C,B)).


/*----------------------DEFINISI STAT PLAYER AWAL DAN ENEMY----------------------*/
/* Dynamic untuk mencatat posisi player*/
:-dynamic(pemain/6).


/*maksimal tingkat kesehatan*/
maksimal_sehat(100).

/*maksimal jumlah peluru*/
maksimal_peluru(100).

/*inisialisasi atribut pemain*/
inis_sehat(100).
inis_senjata(ak47).
inis_peluru(100).
inis_pelindung(helm).

inis_pemain :-
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	/*catat senjata dan pelindung yang dibawa pemain pada inventori*/
	asserta(inventori(Senjata)),
	asserta(inventori(Pelindung)),
	random(2,19,X),
	random(2,19,Y),
	write('Sekarang anda di :'),
	write(X),write(' '),write(Y),
	asserta(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),!.


/*Fakta Enemy*/
:-dynamic(musuh/7).
:-dynamic(jumlahmusuh/1).

/*fungsi random(A,B,X) menghasilkan sebuah angka random antara A dan B*/

list_senjata([ak47,m4a1]).
list_pelindung([helm,kevlar]).
list_ammo(10,40,60,80,100).
list_sehat(10,40,60,80,100).
/*musuh juga bisa bergerak secara random*/
/*random senjata dan pelindung juga bisa dilakukan*/

choose([], []).
choose(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).

inis_musuh(C) :-
	jumlahmusuh(A),B is A+1 , retract(jumlahmusuh(A)),asserta(jumlahmusuh(B)),
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	random(2,19,X),
	write('Muncul musuh '),
	write(C),
	write(' di :'),
	random(2,19,Y),
	write(X),write(' '),write(Y),
	asserta(musuh(C,X,Y,Sehat,Senjata,Peluru,Pelindung)).

moveenemy :- musuh(Nama,X,Y,M,N,O,P),
							random(-1,1,C),random(-1,1,D),V is X+C,W is Y+D,
							retract(musuh(Nama,X,Y,M,N,O,P)),
							asserta(musuh(Nama,V,W,M,N,O,P)),
							write(Nama),
							write(' bergerak ke :'),write(V),write(' '),write(W),nl,fail.
moveenemy :- !.
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

createObjek :-
	random(2,19,A),
	random(2,19,B),
	asserta(obj(helm,A,B)),
	write('helm berhasil ditambahkan pada koordinat ('),write(A),write(','),write(B),write(')'),nl,

	random(2,19,C),
	random(2,19,D),
	asserta(obj(kevlar,C,D)),
	write('kevlar berhasil ditambahkan pada koordinat ('),write(C),write(','),write(D),write(')'),nl,

	random(2,19,E),
	random(2,19,F),
	asserta(obj(pill,E,F)),
	write('pill berhasil ditambahkan pada koordinat ('),write(E),write(','),write(F),write(')'),nl,

	random(2,19,G),
	random(2,19,H),
	asserta(obj(plester,G,H)),
	write('plester berhasil ditambahkan pada koordinat ('),write(G),write(','),write(H),write(')'),nl,

	random(2,19,I),
	random(2,19,J),
	asserta(obj(ak47,I,J)),
	write('ak47 berhasil ditambahkan pada koordinat ('),write(I),write(','),write(J),write(')'),nl,

	random(2,19,K),
	random(2,19,L),
	asserta(obj(m4a1,K,L)),
	write('m4a1 berhasil ditambahkan pada koordinat ('),write(K),write(','),write(L),write(')'),nl.

/*RULE*/


/*===========RULE COMMAND==============*/

/*----------------------MOVE PLAYER OR ENEMY----------------------*/

/*Fungsi Gerak*/
n :-
	pemain(X,Y,M,N,O,P),Z is Y-1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(X,Z,M,N,O,P)),
	write('pemain berhasil bergerak ke utara'),nl,c.
s :-
	pemain(X,Y,M,N,O,P),Z is Y+1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(X,Z,M,N,O,P)),
	write('pemain berhasil bergerak ke selatan'),nl,c.
w :-
	pemain(X,Y,M,N,O,P),Z is X-1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(Z,Y,M,N,O,P)),
	write('pemain berhasil bergerak ke barat'),nl,c.
e :-
	pemain(X,Y,M,N,O,P),Z is X+1,
	retract(pemain(X,Y,M,N,O,P)),
	asserta(pemain(Z,Y,M,N,O,P)),
	write('pemain berhasil bergerak ke timur'),nl,c,createObjek.

c:- deadzone,moveenemy,inside_deadzone,map,kill,final_state.
/*----------------------PRINT MAP----------------------*/
/*Fungsi menggambar map AxA*/
map :- pemain(X,Y,O,P,Q,R),deadzoneCounter(Time,Size),game(20,B,20,Size,X,Y),printmatrix(B).
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
look :- pemain(M,N,O,P,Q,R),deadzoneCounter(Time,Size),game(20,B,20,Size,M,N),looky(20,B,C,20,M,N),cek_obj(C,D,M,N),printmatrix(D).

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

priority(X,Y,'e ') :- musuh(C,X,Y,Sehat,Senjata,Peluru,Pelindung),!.
priority(X,Y,'m ') :- obj(M,X,Y),medic(M),!.
priority(X,Y,'w ') :- obj(W,X,Y),weapon(W),!.
priority(X,Y,'r ') :- obj(R,X,Y),armor(R),!.
priority(X,Y,'a ') :- obj(A,X,Y),ammo(A),!.

/*-------------------Inventori--------------------*/
:-dynamic(inventori/1).


/*----------------------TAKE----------------------*/
take(Objek) :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	obj(A,E,F),
	X =:= E, Y =:= F,
	write('Selamat kamu udah nambahin '),
	write(Objek),
	write(' ke inventori'),nl,
	asserta(inventori(Objek)),!.
	/*tambah objek ke inventori pemain*/
take(Objek) :-
	write('tidak bisa mengambil objek tersebut'),nl,!.

/*----------------------DROP----------------------*/
drop(Objek) :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	write(Objek),
	write(' berhasil dibuang di koordinat ('),write(X),write(','),write(Y),write(')'),nl,
	retract(inventori(Objek)),
	asserta(obj(Objek,X,Y)),!.
	/*buang objek dari inventori pemain*/

/*----------------------USE----------------------*/
useitem(A):- inventori(List),finditem(A,List,NewList),retract(inventori(List)),asserta(inventori(NewList)),effect(A).

finditem(A,[],[]):- write('Item tidak ada'),fail.
finditem(A,[B|C],C):- A=:=B,!.
finditem(A,[B|C],[B|D]):- finditem(A,C,D).

effect(A):- medic(A),!, heal(A,B),pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
						Sehat_sekarang is Sehat + B,
						retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
						asserta(pemain(X,Y,Sehat_sekarang,Senjata,Peluru_sekarang,Pelindung)).


/*----------------------ATTACK (FAIL DAN GOAL STATE DI CEK DISINI)---------------------- */

/*Pemain melakukan serangan*/
serang :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
  musuh(Nama,M,N,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh),
	Peluru > 0,
	T is X+1 , U is X-1 , V is Y+1 , W is Y-1,
	(M =:= T ; M =:= U ),( N =:= V ; N =:= W),!,
	damage(Senjata,DamageSenjata),damage(SenjataMusuh,DamageSenjataMusuh),
	defense(Pelindung,Defense),defense(PelindungMusuh,DefenseMusuh),
	Sehat_sekarang is Sehat - DamageSenjataMusuh + Defense,
	SehatMusuh_sekarang is SehatMusuh - DamageSenjata + DefenseMusuh,
	Peluru_sekarang is Peluru-10,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y,Sehat_sekarang,Senjata,Peluru_sekarang,Pelindung)),
	retract(musuh(Nama,M,N,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh)),
	asserta(musuh(Nama,M,N,SehatMusuh_sekarang,SenjataMusuh,PeluruMusuh,PelindungMusuh)),write('nice shot'),nl,deadzone,moveenemy,inside_deadzone,kill,final_state,!.
serang:- write('Gaada musuh'),nl.

/* Mengecek apakah ada musuh yang health <= 0 */
kill:- 	musuh(Nama,X,Y,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh),
				SehatMusuh =< 0,!,
				jumlahmusuh(A),B is A-1 , retract(jumlahmusuh(A)),asserta(jumlahmusuh(B)),
				write('Musuh gugur 1'),nl,
				retract(musuh(Nama,X,Y,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh)).
kill:- nl.

/* Cek apakah player atau musuh berada di deadzone (lgsg mati)*/
inside_deadzone:- musuh(Nama,X,Y,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh),
										deadzoneCounter(Time,Size), Z is 20-Size,
										(X =< Size ; X>= Z ; Y =< Size ; Y >= Z ),!,
										retract(musuh(Nama,X,Y,SehatMusuh,SenjataMusuh,PeluruMusuh,PelindungMusuh)),
										asserta(musuh(Nama,X,Y,0,SenjataMusuh,PeluruMusuh,PelindungMusuh)).

inside_deadzone:- pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
									deadzoneCounter(Time,Size), Z is 21-Size,
									(X =< Size ; X>= Z ; Y =< Size ; Y >= Z ),!,
									retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
									asserta(pemain(X,Y,0,Senjata,Peluru,Pelindung)).
inside_deadzone:- nl.

final_state:- pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),Sehat =< 0,!,write('Kamu Kalah'),nl,write('Makasih udah main'),nl,!,fail.
final_state:- jumlahmusuh(0),!,write('Kamu Menang'),nl,write('Makasih udah main'),nl,!,fail.
final_state:- nl.

/*----------------------STATUS----------------------*/
/*cek status pemain*/
status :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	write('Koordinat posisi pemain pada ('),write(X), write(','), write(Y), write(')'),nl,
	write('Tingkat kesehatan : '),write(Sehat),nl,
	write('Senjata yang dipegang : '),write(Senjata),nl,
	write('Jumlah peluru yang tersisa : '),write(Peluru),nl,
	write('Pelindung yang dipakai : '),write(Pelindung),nl,
	write('Jumlah musuh yang tersisa : '),jumlahmusuh(A),write(A),nl.

/*Cek menang kalah*/
menang_kalah :-
	jumlahmusuh(A),
	A =:= 0,
	write('menang'),!.


menang_kalah :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	Sehat =:= 0,
	write('kalah'),!.
	/*setelah itu keluar dari program*/

/* save/load */
save :-
	open('savepemain.txt',write,Stream),
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	deadzoneCounter(X1,Y1),
	write(Stream,X),
	write(Stream,'.\n'),
	write(Stream,Y),
	write(Stream,'.\n'),
	write(Stream,Sehat),
	write(Stream,'.\n'),
	write(Stream,Senjata),
	write(Stream,'.\n'),
	write(Stream,Peluru),
	write(Stream,'.\n'),
	write(Stream,Pelindung),
	write(Stream,'.\n'),
	write(Stream,X1),
	write(Stream,'.\n'),
	write(Stream,Y1),
	write(Stream,'.\n'),
	close(Stream),
	open('savemusuh.txt',write,Strm),
	jumlahmusuh(A),
	write(Strm,A),
	write(Strm,'.\n'),
	musuh(tuyul,J,K,M,N,O,P),
	write(Strm, 'tuyul'),
	write(Strm, '.\n'),
	write(Strm,J),
	write(Strm,'.\n'),
	write(Strm,K),
	write(Strm,'.\n'),
	write(Strm,M),
	write(Strm,'.\n'),
	write(Strm,N),
	write(Strm,'.\n'),
	write(Strm,O),
	write(Strm,'.\n'),
	write(Strm,P),
	write(Strm,'.\n'),
	musuh(ular,J1,K1,M1,N1,O1,P1),
	write(Strm, 'ular'),
	write(Strm, '.\n'),
	write(Strm,J1),
	write(Strm,'.\n'),
	write(Strm,K1),
	write(Strm,'.\n'),
	write(Strm,M1),
	write(Strm,'.\n'),
	write(Strm,N1),
	write(Strm,'.\n'),
	write(Strm,O1),
	write(Strm,'.\n'),
	write(Strm,P1),
	write(Strm,'.\n'),
	musuh(polisi,J2,K2,M2,N2,O2,P2),
	write(Strm, 'polisi'),
	write(Strm, '.\n'),
	write(Strm,J2),
	write(Strm,'.\n'),
	write(Strm,K2),
	write(Strm,'.\n'),
	write(Strm,M2),
	write(Strm,'.\n'),
	write(Strm,N2),
	write(Strm,'.\n'),
	write(Strm,O2),
	write(Strm,'.\n'),
	write(Strm,P2),
	write(Strm,'.\n'),
	close(Strm).
	
load :-
	open('savepemain.txt',read,S),
	read(S,H1),
	read(S,H2),
	read(S,H3),
	read(S,H4),
	read(S,H5),
	read(S,H6),
	read(S,H7),
	read(S,H8),
	close(S),
	asserta(pemain(H1,H2,H3,H4,H5,H6)),
	asserta(deadzoneCounter(H7,H8)),
	open('savemusuh.txt',read,S1),
	read(S1,A),
	asserta(jumlahmusuh(A)),
	read(S1,A1),
	read(S1,A2),
	read(S1,A3),
	read(S1,A4),
	read(S1,A5),
	read(S1,A6),
	read(S1,A7),
	asserta(musuh(A1,A2,A3,A4,A5,A6,A7)),
	read(S1,B1),
	read(S1,B2),
	read(S1,B3),
	read(S1,B4),
	read(S1,B5),
	read(S1,B6),
	read(S1,B7),
	asserta(musuh(B1,B2,B3,B4,B5,B6,B7)),
	read(S1,C1),
	read(S1,C2),
	read(S1,C3),
	read(S1,C4),
	read(S1,C5),
	read(S1,C6),
	read(S1,C7),
	close(S1),
	asserta(musuh(C1,C2,C3,C4,C5,C6,C7)).
