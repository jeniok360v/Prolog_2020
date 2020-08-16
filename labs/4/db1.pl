wyrazenie([X], X, X).
wyrazenie(Lista, Wartosc, Wyrazenie) :-
    L = [_|_],
    R = [_|_],
    append(L, R, Lista),
    wyrazenie_(L, Wyrazenie1),
    wyrazenie_(R, Wyrazenie2),
    join(Wyrazenie, Wyrazenie1, Wyrazenie2),
    Wartosc is Wyrazenie.

wyrazenie_([X], X).
wyrazenie_(Lista, Wyrazenie) :-
    L = [_|_],
    R = [_|_],
    append(L, R, Lista),
    wyrazenie_(L, Wyrazenie1),
    wyrazenie_(R, Wyrazenie2),
    join(Wyrazenie, Wyrazenie1, Wyrazenie2).

join(Out, Wyrazenie1, Wyrazenie2) :-
    Out = Wyrazenie1 + Wyrazenie2.

join(Out, Wyrazenie1, Wyrazenie2) :-
    Out = Wyrazenie1 - Wyrazenie2.

join(Out, Wyrazenie1, Wyrazenie2) :-
    Out = Wyrazenie1 * Wyrazenie2.

join(Out, Wyrazenie1, Wyrazenie2) :-
    Wyrazenie2 =\= 0,
    Out = Wyrazenie1 / Wyrazenie2.
