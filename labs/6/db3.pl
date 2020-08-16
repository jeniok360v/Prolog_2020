% punkt 1.
p1 --> [].
p1 --> [a], p1, [b].

% punkt 2.
p2 --> {natural_number(N)}, as(N), bs(N), cs(N).
as(0) --> {!}, [].
as(N) --> {NewN is N - 1}, [a], as(NewN).
bs(0) --> {!}, [].
bs(N) --> {NewN is N - 1}, [b], bs(NewN).
cs(0) --> {!}, [].
cs(N) --> {NewN is N - 1}, [c], cs(NewN).

natural_number(0).
natural_number(N) :-
	natural_number(P),
	N is P + 1.

% punkt 3.
p3 --> {natural_number(N), fibonacci(N, F)}, as(N), bs(F).

% fibonacci(N, F) jest prawdziwy, jeśli F jest N-tą liczbą Fibonacciego
fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(N, F) :-
	N1 is N - 1,
	N2 is N - 2,
	fibonacci(N1, F1),
	fibonacci(N2, F2),
	F is F1 + F2.
	
% gramatyka z pytania
p([]) --> [].
p([X | Xs]) --> [X], p(Xs).