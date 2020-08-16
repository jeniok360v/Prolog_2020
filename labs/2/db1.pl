dllisty([],0).
dllisty([G|O], N) :-
	dllisty(O, N1),
	N is N1+1.


srodkowy(Lista, Elem) :-
	dllisty(Lista, Dlugosc),
	1 is mod(Dlugosc, 2),
	Srodkowy is (Dlugosc-1)/2,
	nth0(Srodkowy, Lista, Elem).
