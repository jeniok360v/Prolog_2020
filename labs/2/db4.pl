regula(X, /, Y, _) :-
	number(Y),
	(Y =:= 0),
	halt,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

regula(X-Y, +, Y, X) :-
	atomic(X),
	atomic(Y),!.

regula(X+Y, +, X, 2*X+Y) :-
	atomic(X),
	atomic(Y),!.

regula(X+Y, -, X, Y) :-
	atomic(X),
	atomic(Y),!.
	
regula(X/Y, *, Y, X) :-
	atomic(X),
	atomic(Y),!.

regula(X*Y, /, X, Y) :-	
	atomic(X),
	atomic(Y),!.

regula(X*Y, /, Y, X) :-	
	atomic(X),
	atomic(Y),!.

regula(X/Y, /, X, 1/X) :-	
	atomic(X),
	atomic(Y),!.
	
regula(X/X, /, Y, 1/Y) :-	
	atomic(X),
	atomic(Y),!.	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

regula(X, +, Y, Y) :-
	number(X),
	X =:= 0, !.
	
regula(X, +, Y, X) :-
	number(Y),
	Y =:= 0, !.

regula(X, +, Y, Wynik) :-
	number(X),
	number(Y),
	Wynik is X+Y,!.
	
regula(X, +, Y, Wynik) :-
	Wynik = X+Y,!.	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		

regula(X, -, Y, 0) :-	
	atomic(X),
	atomic(Y),
	X = Y, !.	

regula(X, -, Y, X) :-
	number(Y),
	Y =:= 0, !.

regula(X, -, Y, -Y) :-
	number(X),
	X =:= 0, !.
	
regula(X, -, Y, Wynik) :-
	number(X),
	number(Y),
	Wynik is X-Y,!.	

regula(X, -, Y, Wynik) :-
	Wynik = X-Y,!.	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1+2+a*1+0/b-c*0

regula(X, *, Y, X) :-	
	number(Y),
	Y =:= 1, !.
	
regula(X, *, Y, Y) :-	
	number(X),
	X =:= 1, !.	
	
regula(X, *, Y, 0) :-	
	number(Y),
	Y =:= 0, !.
	
regula(X, *, Y, 0) :-	
	number(X),
	X =:= 0, !.

regula(X, *, Y, Wynik) :-
	number(X),
	number(Y),
	Wynik is X*Y,!.
	
regula(X, *, Y, Wynik) :-
	Wynik = X*Y,!.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%		

regula(X, /, Y, 0) :-
	number(X),
	X =:= 0, !.	
	
regula(X, /, X, 1) :-
	atomic(X),
	number(X),
	X =\= 0, !.		
	
regula(X, /, X, 1) :-
	atomic(X),!.	
	
regula(X, /, Y, Wynik) :-
	Wynik = X/Y,!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%

uprosc(Wyrazenie, Wynik) :- 
	(
		atomic(Wyrazenie); 
		number(Wyrazenie)
	),
	Wyrazenie = Wynik.	
	
uprosc(Wyrazenie,Wynik) :-
	Wyrazenie =.. [Operacja, Wyr1, Wyr2],
	uprosc(Wyr1, Wyn1),
	uprosc(Wyr2, Wyn2),
	regula(Wyn1, Operacja, Wyn2, Wynik)
	.

	