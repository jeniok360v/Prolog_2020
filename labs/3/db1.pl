dllisty([],0).
dllisty([G|O], N) :-
	dllisty(O, N1),
	N is N1+1.

sqr([],[]).
sqr([H1|T1], [H2|T2]) :-
	sqr(T1,T2),
	H2 is H1**2.
	
sumList([],0).
sumList([H|T], N) :-
	sumList(T, N1),
	N is H+N1.
	
var(Lista, X) :-
	dllisty(Lista, Dl),
	sqr(Lista, SqrLista),
	sumList(Lista, Sum1),
	sumList(SqrLista, Sum2),
	X is (Dl*Sum2-Sum1**2)/Dl**2.
	