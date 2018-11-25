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

:-dynamic(musuh/6).


choose([], []).
choose(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).
        
inis_musuh :- 
	inis_sehat(Sehat),
	inis_senjata(Senjata),
	inis_peluru(Peluru),
	inis_pelindung(Pelindung),
	random(1,20,X),
	random(1,20,Y),
	asserta(musuh(X,Y,Sehat,Senjata,Peluru,Pelindung)),!.
