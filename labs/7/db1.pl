merge(L1, L2, Out) :-
	freeze(
		L1, 
		freeze(
			L2, 
			(
				L1 = [H1|T1] ->
				(
					L2 = [H2|T2] ->
					(   
						H1 @< H2 ->  
						(Out = [H1|OutL], merge(T1, L2, OutL));
						(Out = [H2|OutR], merge(L1, T2, OutR))
					);
					Out = L1
				);
				Out = L2
			)
		)
	).
