rybki(Kto) :-
    Domy = [dom(_, norweg, _, _, _), _, _, _, _],
    member(dom(czerwony, anglik, _, _, _), Domy),
    leftNeighbour(dom(zielony, _, _, _, _), dom(bialy, _, _, _, _), Domy),
    member(dom(_, dunczyk, _, herbata, _), Domy),
    neighbour(dom(_, _, _, _, light), dom(_, _, koty, _, _), Domy),
    member(dom(zolty, _, _, _, cygara), Domy),
    member(dom(_, niemiec, _, _, fajka), Domy),
	Domy = [_, _, dom(_, _, _, mleko, _), _, _],
    neighbour(dom(_, _, _, _, light), dom(_, _, _, woda, _), Domy),
    member(dom(_, _, ptaki, _, bez_filtra), Domy),
    member(dom(_, szwed, psy, _, _), Domy),
    neighbour(dom(_, norweg, _, _, _), dom(niebieski, _, _, _, _), Domy),
    neighbour(dom(_, _, konie, _, _), dom(zolty, _, _, _, _), Domy),
    member(dom(_, _, _, piwo, mentolowe), Domy),
    member(dom(zielony, _, _, kawa, _), Domy),
	
    member(dom(_, Kto, rybki, _, _), Domy).


leftNeighbour(L, R, [L, R|_]).
leftNeighbour(L, R, [_|T]) :-
    leftNeighbour(L, R, T).

rightNeighbour(R, L, [L, R|_]).
rightNeighbour(R, L, [_|T]) :-
    rightNeighbour(R, L, T).

neighbour(Dom1, Dom2, Domy) :-
    leftNeighbour(Dom1, Dom2, Domy);
    rightNeighbour(Dom1, Dom2, Domy).