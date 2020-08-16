maxlist([X],X).
maxlist([H|T],Max) :-
    maxlist(T,Max1),
    (H > Max1 -> Max is H ; Max is Max1).


max_s([], 0, 0).
max_s([H|T], LocalSum, Max) :-
	max_s(T, LocalSum2, Max2),
	((LocalSum2+H < 0) -> (LocalSum is 0) ; (LocalSum is LocalSum2 + H)),
	(LocalSum > Max2 -> Max is LocalSum ; Max is Max2).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% jesli lista jest niepusta i
% sa tylko elementy =< 0, to
% szukamy po prostu najwiekszy elem.
	
max_sum(Lista, Max) :-	
	max_s(Lista, _, Max1),
	((Max1 =:= 0, Lista=[_|_]) -> (maxlist(Lista, Max)) ; Max is Max1).
	