% samochod
% bicycle				aparat
% pencil	klepsydra	motyl	ryba


left_of_rec(X, Y) :- left_of(X,Y).

left_of_rec(X, Y) :- 
	left_of(X, Z),
	left_of_rec(Z, Y).

left_of(pencil, hourglass).
left_of(hourglass, butterfly).
left_of(butterfly, fish).


above_rec(X, Y) :- above(X,Y).

above_rec(X, Y) :- 
	above(X, Z),
	above_rec(Z, Y).

above(car, bicycle).
above(bicycle, pencil).
above(camera, butterfly).


right_of(X, Y) :-
	left_of(Y, X).
	
below(X, Y) :-
	above(Y, X).
	
higher(X, Y) :-
	(left_of_rec(Y, Z), above_rec(X, Z));
	(left_of_rec(Z, Y), above_rec(X, Z));
	above_rec(X, Y).
	
	