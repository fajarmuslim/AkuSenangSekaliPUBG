/*pemain memiliki beberapa atribut*/
/*Health, tingkat kesehatan pemain*/
/*Senjata, senjata yang dipegang pemain*/
/*Pelindung, pelindung dari serangan musuh*/
/*Peluru, jumlah peluru*/

/*pemain memiliki 4 atribut*/
:-dynamic(pemain/6).

/*daftar senjata selama permainan*/
/*format (senjata, seberapa kerusakan yang ditimbulkan*/
senjata(basoka,20).
senjata(pistol,10).
senjata(ketapel,5).

/*Daftar armor selama permainan*/
pelindung(baju,20).
pelindung(celana,20).
pelindung(helm,30).
pelindung(tameng,50).

/*maksimal tingkat kesehatan*/
maksimal_sehat(100).

/*maksimal jumlah peluru*/
maksimal_peluru(100).

/*inisialisasi atribut pemain*/
inis_sehat(100).
inis_senjata(ketapel).
inis_peluru(100).
inis_pelindung(tameng).


/*inisialisasi pemain*/
/*X Y merupakan koordinat pemain saat awal permainan*/
inis_pemain :- 
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	random(1,20,X),
	random(1,20,Y),
	asserta(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),!.

/*cek status pemain*/
status_pemain :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	write('Koordinat posisi pemain pada ('),write(X), write(','), write(Y), write(')'),nl,
	write('Tingkat kesehatan : '),write(Sehat),nl,
	write('Senjata yang dipegang : '),write(Senjata),nl,
	write('Jumlah peluru yang tersisa : '),write(Peluru),nl,
	write('Pelindung yang dipakai : '),write(Pelindung),nl.

/*Pemain melakukan serangan*/
serang :- 
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	Peluru_sekarang is Peluru-10,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y,Sehat,Senjata,Peluru_sekarang,Pelindung)),!.
	

/*pemain diserang oleh musuh*/
diserang :- 
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	senjata(Senjata,Kerusakan),
	Sehat_sekarang is Sehat - Kerusakan,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y,Sehat_sekarang,Senjata,Peluru,Pelindung)),!.
	
kanan :- 
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	X1 is X+1,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X1,Y,Sehat,Senjata,Peluru,Pelindung)),!.

kiri :- 
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	X1 is X-1,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X1,Y,Sehat,Senjata,Peluru,Pelindung)),!.

atas :- 
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	Y1 is Y+1,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y1,Sehat,Senjata,Peluru,Pelindung)),!.
	
bawah :-
	pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
	Y1 is Y+1,
	retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
	asserta(pemain(X,Y1,Sehat,Senjata,Peluru,Pelindung)),!.


drop(Objek) :-
	write(Objek).
	/*buang objek dari inventori pemain*/
	
take(Objek) :-
	write(Objek).
	/*tambah objek ke inventori pemain*/
