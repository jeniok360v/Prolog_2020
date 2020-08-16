parzysta([], []).
parzysta([H|T], Perm1) :-
    parzysta(T, Perm2),
    wstaw_nieparzysta(H, Perm2, Perm1).
parzysta([H|T], Perm1) :-
    nieparzysta(T, Perm2),
    wstaw_parzysta(H, Perm2, Perm1).


nieparzysta([H|T], Perm1) :-
    nieparzysta(T, Perm2),
    wstaw_nieparzysta(H, Perm2, Perm1).
nieparzysta([H|T], Perm1) :-
    parzysta(T, Perm2),
    wstaw_parzysta(H, Perm2, Perm1).


wstaw_nieparzysta(X, L1, [X|L1]).
wstaw_nieparzysta(X, [Y,Z|L1], [Y,Z|L2]) :-
    wstaw_nieparzysta(X, L1, L2).


wstaw_parzysta(X, [Y|L1], [Y,X|L1]).
wstaw_parzysta(X, [Y,Z|L1], [Y,Z|L2]) :-
    wstaw_parzysta(X, L1, L2).