%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mojalista to przeksztalcony numlist z                                %
% https://www.swi-prolog.org/pldoc/doc/_SWI_/library/lists.pl?show=src %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mojalista(L, U, Ns) :-
	must_be(integer, L),
	must_be(integer, U),
	L =< U,
	mojalista_(L, U, Ns).
mojalista_(U, U, List) :-
	!,
	List = [U,U].	
mojalista_(L, U, [L,L|Ns]) :-
	L2 is L+1,
	mojalista_(L2, U, Ns).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nie zrobilem porzadna permutacje, 
% ale czesci powtorzen jednak 
% udalo sie pozbyc

appendlist([], X, X).
appendlist([T|H], X, [T|L]) :- 
	appendlist(H, X, L).

permutat([], []).
permutat([X], [X]) :-!.
permutat([T|H], X) :- 
	permutat(H, H1), 
	appendlist(L1, L2, H1), 
	(\+L2=[_|_] ;  (L2=[G|_], G =\= T)),
	appendlist(L1, [T], X1), 
	appendlist(X1, L2, X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dllisty([],0).
dllisty([G|O], N) :-
	dllisty(O, N1),
	N is N1+1.

dwukrotnie(Lista, Elem) :-
	select(Elem, Lista, ListaWyjsc1),
	select(Elem, ListaWyjsc1, ListaWyjsc2),
	\+(select(Elem, ListaWyjsc2, ListaWyjsc3)).

parzysta_odleglosc(Lista, Elem) :-
	nth1(X, Lista, Elem),
	select(Elem, Lista, ListaWyjsc),
	nth1(Y, ListaWyjsc, Elem),!,
	0 is mod(X+Y, 2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% jesli po raz pierwszy pojawila sie liczba x,
% to na poprzednich pozycjach ciagu juz sa
% 1,2,...,x-1.

cr(Lista, Elem) :-
	nth1(Ind, Lista, Elem),
	Liczby is Elem-1,!,
	forall(between(1,Liczby,X), (nth1(Index, Lista, X), Index<Ind )).

sprawdz(List, N) :-
	dllisty(List, Dl),
%	0 is mod(Dl, 2),
	N is Dl/2,
%	foreach(between(1,N,X), dwukrotnie(List, X)),
	foreach(between(1,N,X), parzysta_odleglosc(List, X)),
	forall(between(1,N,X), cr(List,X)).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%          main          %
%%%%%%%%%%%%%%%%%%%%%%%%%%

list_gen(N, Lista) :-
	mojalista(1, N, Moja_lista),
	permutat(Moja_lista, Lista),
	sprawdz(Lista, N).

