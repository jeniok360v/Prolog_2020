:- ['./db1.pl'].

split(In, L, R) :- 
	freeze(
		In, 
		(
			In = [H1|In1] -> 
			(L = [H1|Left1], split(In1, R, Left1));
			(L = [], R = [])
		)
	).

merge_sort(X, Y) :- 
	freeze(
		X, 
		(   
			X = [_|X1] -> 
			freeze(
				X1, 
				(X1 = [_|_] -> 
				(
					split(X, L, R),
					merge_sort(L, L1),
					merge_sort(R, R1), 
					merge(L1, R1, Y)
				);   
				Y = X
				)
			); 
		Y = X
		)
	).