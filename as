use(Objek) :- inventori(Objek),medic(Objek),pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),heal(Objek,H),Sehat_sekarang is Sehat + H,Sehat_sekarang =< 100,!,
		retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
		retract(inventory(Objek)),write(Objek),write(' berhasil dipakai'),nl,
	asserta(pemain(X,Y,Sehat_sekarang,Senjata,Peluru,Pelindung)).

use(Objek) :- inventori(Objek),weapon(Objek),!,pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
		asserta(inventori(Senjata)),
		retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),write(Objek),write(' berhasil dipakai'),nl,
		
	asserta(pemain(X,Y,Sehat,Objek,Peluru,Pelindung)),retract(inventori(Objek)).

use(Objek) :- inventori(Objek),armor(Objek),!,pemain(X,Y,Sehat,Senjata,Peluru,Pelindung),
		asserta(inventori(Pelindung)),write(Objek),write(' berhasil dipakai'),nl,
		retract(pemain(X,Y,Sehat,Senjata,Peluru,Pelindung)),
		
	asserta(pemain(X,Y,Sehat,Objek,Peluru,Objek)),retract(inventori(Objek)).assads
