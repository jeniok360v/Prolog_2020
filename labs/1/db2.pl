on(b1, b2).
on(b2, b3).
on(b3, b4).
on(b4, b5).
on(b5, b6).
on(b6, b7).

above(X, Y) :- on(X, Y).

above(B1, B2) :-
	on(B1, B),
	above(B, B2).
