arc(a,b).
arc(b,a).
arc(b,c).
arc(c,d).


sciezka(X, Z, V) :-
	arc(X, Y),
	\+(member(Y, V)),
	(Y = Z; sciezka(Y,Z,[Y|V])).

osiagalny(X,Y) :-
	sciezka(X,Y,[]).

