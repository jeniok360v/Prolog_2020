%relacja
le(a0,a1).
le(a1,a2).
le(a1,a3).
le(a2,a4).
le(a3,a4).

%zwrotnosc
le(a0, a0).
le(a1, a1).
le(a2, a2).
le(a3, a3).
le(a4, a4).

%przechodnosc
le(a0, a2).
le(a0, a3).
le(a0, a4).
le(a1, a4).


%le(a2, a0).


zbior(X) :-
	le(X, _);
	le(_, X).


%	a2 - a4
%	|    |
%	a1 - a3
%	|
%	a0


czesciowy_porzadek :-
	forall(zbior(Y), le(Y,Y)),
	
	forall((zbior(X), zbior(Y), zbior(Z)), 
		((le(X,Z); \+ (le(X,Y)); \+ (le(Y,Z))))
	),
	
	forall((zbior(X), zbior(Y)), 
		(\+ (le(X,Y)); \+ (le(Y, X)); X==Y)
	).






















