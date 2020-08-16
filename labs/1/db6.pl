prime(X,Y) :-
	foreach(between(X,Y,A),
		pierwsza(A) -> writeln(A); !
	).


pierwsza(2).
pierwsza(A) :-
	not(A<2),
	not((A1 is ceiling(sqrt(A)),
		between(2,A1,N), 
		0 is mod(A,N))
	).
 
