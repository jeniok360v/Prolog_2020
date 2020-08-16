maxlist([X],X).
maxlist([H|T],Max) :-
    maxlist(T,Max1),
    (H > Max1 -> Max is H ; Max is Max1).


max_s([], X, X, Y, Y).
max_s([H|T], LocalSumIn, LocalSumOut, MaxIn, MaxOut) :-
	((LocalSumIn+H < 0) -> (LocalSum is 0) ; (LocalSum is LocalSumIn + H)),
	(LocalSum > MaxIn -> Max is LocalSum ; Max is MaxIn),
	max_s(T, LocalSum, LocalSumOut, Max, MaxOut).
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% jesli lista jest niepusta i
% sa tylko elementy =< 0, to
% szukamy po prostu najwiekszy elem.
	
max_sum(Lista, Max) :-	
	max_s(Lista, 0, _, 0, Max1),
	((Max1 =:= 0, Lista=[_|_]) -> (maxlist(Lista, Max)) ; Max is Max1).
	