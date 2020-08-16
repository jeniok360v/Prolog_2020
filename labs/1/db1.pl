jest_matka(X) :-
	matka(X, _).

jest_ojcem(X) :-
	ojciec(X, _).
	
jest_synem(X) :-
	mezczyzna(X),
	ojciec(O, X), 
	matka(M, X).

siostra(X) :-
	kobieta(X),
	matka(M, X),
	matka(M, Y),
	X \= Y.

dziadek(X, Y) :-
	ojciec(X, Z),
	ojciec(Z, Y).

rodzenstwo(X, Y) :-
	matka(A, X),
	matka(B, Y),
	A = B.

mezczyzna(bernard).
mezczyzna(kuba).
kobieta(klaudia).
kobieta(katarzyna).

matka(alicja, katarzyna).
matka(alicja, kuba).
matka(alicja, klaudia).

ojciec(pawel, katarzyna).
ojciec(pawel, kuba).
ojciec(pawel, klaudia).

ojciec(kuba, czeslaw).

ojciec(andrzej, bernard).


