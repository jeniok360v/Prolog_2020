board(L) :-
	length(L, N),
	(even_number(N) -> draw_board(L, N, white, N); draw_board(L, N, black, N)),
	!.
	

draw_board(_, N, _, 0) :-
	draw_edges(N).
draw_board(L, N, StartColor, Row) :-
	draw_edges(N),
	write('\n'),
	draw_fields(L, N, StartColor, Row, 1),
	write('\n'),
	draw_fields(L, N, StartColor, Row, 1),
	write('\n'),
	NewRow is Row - 1,
	(StartColor = white -> NewStartColor = black; NewStartColor = white),
	draw_board(L, N, NewStartColor, NewRow).
	

draw_fields(L, N, Color, Row, N) :-
	draw_last_field(L, N, Color, Row, N).
draw_fields(L, N, Color, Row, Column) :-
	draw_field(L, N, Color, Row, Column),
	NewColumn is Column + 1,
	(Color = white -> NewColor = black; NewColor = white),
	L = [_ | Rest],
	draw_fields(Rest, N, NewColor, Row, NewColumn).

draw_last_field(L, _, white, Row, Column) :-
	queen_on_field(L, Row, Column),
	!,
	write('| ### |').

draw_last_field(_, _, white, _, _) :-
	write('|     |').
	
draw_last_field(L, _, black, Row, Column) :-
	queen_on_field(L, Row, Column),
	!,
	write('|:###:|').
	
draw_last_field(_, _, black, _, _) :-
	write('|:::::|').
	
draw_field(L, _, white, Row, Column) :-
	queen_on_field(L, Row, Column),
	!,
	write('| ### ').
	
draw_field(_, _, white, _, _) :-
	write('|     ').
	
draw_field(L, _, black, Row, Column) :-
	queen_on_field(L, Row, Column),
	!,
	write('|:###:').
	
draw_field(_, _, black, _, _) :-
	write('|:::::').


draw_edges(1) :-
	draw_last_edge.
draw_edges(N) :-
	draw_edge,
	M is N - 1,
	draw_edges(M).
	
draw_edge :-
	write('+-----').
	
draw_last_edge :-
	write('+-----+').
	

queen_on_field([First | _], First, _).

even_number(0) :-
	!.
even_number(1) :-
	!, fail.
even_number(N) :-
	M is N - 2,
	even_number(M).
	
	
hetmany(N, P) :-
	numlist(1, N, L),
	perm(L, P),
	\+ wrong(P).

perm([], []).
perm(L1, [X | L3]) :-
	select(X, L1, L2),
	perm(L2, L3).



wrong(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K + 1.	