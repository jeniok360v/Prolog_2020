:- use_module(library(clpfd)).

plecak(Wartosci, Wielkosci, Pojemnosc, Zmienne) :-
	length(Wartosci, N),
	length(Wielkosci, N),
	length(Zmienne, N),
	Zmienne ins 0..1,
	scalar_product(Wielkosci, Zmienne, #=, Weight),
	scalar_product(Wartosci, Zmienne, #=, Volume),
	Weight #=< Pojemnosc,
	once(labeling([max(Volume)], Zmienne)).