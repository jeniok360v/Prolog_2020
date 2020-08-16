zapalki(N, (duze(D), srednie(S), male(M))) :-
	Amount is 24 - N,
	squares(_, Amount, D, S, M).
	
zapalki(N, (duze(D), srednie(S))) :-
	Amount is 24 - N,
	squares(_, Amount, D, S, 0).	
	
zapalki(N, (duze(D), male(M))) :-
	Amount is 24 - N,
	squares(_, Amount, D, 0, M).
	
zapalki(N, (srednie(S), male(M))) :-
	Amount is 24 - N,
	squares(_, Amount, 0, S, M).

zapalki(N, (duze(D))) :-
	Amount is 24 - N,
	squares(_, Amount, D, 0, 0).
	
zapalki(N, (srednie(S))) :-
	Amount is 24 - N,
	squares(_, Amount, 0, S, 0).
	
zapalki(N, (male(M))) :-
	Amount is 24 - N,
	squares(_, Amount, 0, 0, M).


matches([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).

% kwadraty
small([1, 4, 5, 8]).
small([2, 5, 6, 9]).
small([3, 6, 7, 10]).
small([8, 11, 12, 15]).
small([9, 12, 13, 16]).
small([10, 13, 14, 17]).
small([15, 18, 19, 22]).
small([16, 19, 20, 23]).
small([17, 20, 21, 24]).
medium([1,2, 4,6, 11,13, 15,16]).
medium([2,3, 5,7, 12,14, 16,17]).
medium([8,9, 11,13, 18,20, 22,23]).
medium([9,10, 12,14, 19,21, 23,24]).
big([1,2,3, 4,7, 11,14, 18,21, 22,23,24]).

squares(L, N, 1, S, M) :-
	matches(AllMatches),
	set_of_small(AllMatches, AllSmall, _),
	set_of_medium(AllMatches, AllMedium, _),
	big(List_of_big),
	required_subset(M, AllSmall, Small),
	required_subset(S, AllMedium, Medium),
	elements(List_of_small, Small),
	elements(List_of_medium, Medium),
	union(List_of_big, List_of_medium, Sum1),
	union(List_of_small, Sum1, Sum2),
	sort(Sum2, L),
	length(L, N),
	set_of_small(L, _, M),
	set_of_medium(L, _, S),
	amount_of_big(L, 1),
	paint(L).
	
squares(L, N, 0, S, M) :-
	matches(AllMatches),
	set_of_small(AllMatches, AllSmall, _),
	set_of_medium(AllMatches, AllMedium, _),
	required_subset(M, AllSmall, Small),
	required_subset(S, AllMedium, Medium),
	elements(List_of_small, Small),
	elements(List_of_medium, Medium),
	union(List_of_small, List_of_medium, Sum1),
	sort(Sum1, L),
	length(L, N),
	set_of_small(L, _, M),
	set_of_medium(L, _, S),
	big(List_of_big),
	\+ subset(List_of_big, L),
	paint(L).
	
	
% lista Small to maly kwadrat
is_small(L, Small) :-
	small(Small),
	subset(Small, L).
	

set_of_small(L, Small, N) :-
	set_of_small(L, [], Small, N, 0).

set_of_small(L, Ms, Small, N, Init_N) :-
	is_small(L, M),
	\+ member(M, Ms),
	append([M], Ms, Ms2),
	Init_N2 is Init_N + 1,
	set_of_small(L, Ms2 , Small, N, Init_N2), !.
set_of_small(L, Ms, Small, N, Init_N) :-
	\+ (is_small(L, M), \+ member(M, Ms)),
	Small = Ms,
	N = Init_N.
	

is_medium(L, Medium) :-
	medium(Medium),
	subset(Medium, L).


set_of_medium(L, Ms, Medium, N, Init_N) :-
	is_medium(L, M),
	\+ member(M, Ms),
	append([M], Ms, Ms2),
	Init_N2 is Init_N + 1,
	set_of_medium(L, Ms2 , Medium, N, Init_N2), !.
set_of_medium(L, Ms, Medium, N, Init_N) :-
	\+ (is_medium(L, M), \+ member(M, Ms)),
	Medium = Ms,
	N = Init_N.
set_of_medium(L, Medium, N) :-
	set_of_medium(L, [], Medium, N, 0).
	
	
amount_of_big(L, 1) :-
	big(Big),
	subset(Big, L),!.
amount_of_big(L, 0) :-
	big(Big),
	\+ subset(Big, L).


required_subset(0, [], []).
required_subset(Len, [H|T], [H|NewT]):-
	NewLen is Len - 1,
	(NewLen > 0 -> required_subset(NewLen, T, NewT) ; NewT=[]).
required_subset(Len, [_|T], NewT):-
	required_subset(Len, T, NewT).
	

paint(L) :-
	matches(AllMatches),
	paint(L, AllMatches).
paint(L, AllMatches) :-
	AllMatches = [X | T],
	member(X, L),
	paint_match(X),
	paint(L, T).
paint(_, []).
paint(L,AllMatches) :-
	AllMatches = [X | T],
	\+ member(X, L),
	paint_empty(X),
	paint(L, T).


elements(Elems, L) :-
	elements(Elems, [], L).
elements(Elems, Init_elem, L) :-
	L = [H | T],
	append(H, Init_elem, Init_elem2),
	elements(Elems, Init_elem2, T), !.
elements(Elems, Init_elem, []) :-
	Elems =  Init_elem.
	
	
paint_empty(X) :-
	member(X, [1,2,8,9,15,16,22,23]),
	write('+   ').
paint_empty(X) :-
	member(X, [3,10,17,24]),
	write('+   +'), nl.
paint_empty(X) :-
	member(X, [4,5,6,11,12,13,18,19,20]),
	write('    ').
paint_empty(X) :-
	member(X, [7,14,21]),
	write(' '), nl.

paint_match(X) :-
	member(X, [1,2,8,9,15,16,22,23]),
	write('+---').
paint_match(X) :-
	member(X, [3,10,17,24]),
	write('+---+'), nl.
paint_match(X) :-
	member(X, [4,5,6,11,12,13,18,19,20]),
	write('|   ').
paint_match(X) :-
	member(X, [7,14,21]),
	write('|'), nl.
