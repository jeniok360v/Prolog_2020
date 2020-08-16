wykonaj(NazwaPliku) :-
	open(NazwaPliku, read, X),
	scanner(X, Y),
	close(X),
	phrase(program(PROGRAM), Y),
	interpreter(PROGRAM).


interpreter(PROGRAM) :-
    interpreter(PROGRAM, []).
interpreter([], _).
interpreter([read(ID) | INSTRUKCJE], ASOC) :- 
	!,
    read(N),
    integer(N),
    set(ASOC, ID, N, ASOC1),
    interpreter(INSTRUKCJE, ASOC1).
interpreter([write(W) | INSTRUKCJE], ASOC) :- 
	!,
    value(W, ASOC, WART),
    write(WART), nl,
    interpreter(INSTRUKCJE, ASOC).
interpreter([assign(ID, W) | INSTRUKCJE], ASOC) :- 
	!,
    value(W, ASOC, WAR),
    set(ASOC, ID, WAR, ASOC1),
    interpreter(INSTRUKCJE, ASOC1).
interpreter([if(C, P) | INSTRUKCJE], ASOC) :- 
	!,
    interpreter([if(C, P, []) | INSTRUKCJE], ASOC).
interpreter([if(C, P1, P2) | INSTRUKCJE], ASOC) :- 
	!,
    (
		truth(C, ASOC) ->  
		append(P1, INSTRUKCJE, DALEJ); 
		append(P2, INSTRUKCJE, DALEJ)
	),
    interpreter(DALEJ, ASOC).
interpreter([while(C, P) | INSTRUKCJE], ASOC) :- 
	!,
    append(P, [while(C, P)], DALEJ),
    interpreter([if(C, DALEJ) | INSTRUKCJE], ASOC).

set([], ID, N, [ID = N]).
set([ID = _ | ASOC], ID, N, [ID = N | ASOC]) :- !.
set([ID1 = W1 | ASOC1], ID, N, [ID1 = W1 | ASOC2]) :-
    set(ASOC1, ID, N, ASOC2).

put([ID = N | _], ID, N) :- !.
put([_ | ASOC], ID, N) :-
    put(ASOC, ID, N).

value(int(N), _, N).
value(id(ID), ASOC, N) :-
    put(ASOC, ID, N).
value(W1+W2, ASOC, N) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N is N1+N2.
value(W1-W2, ASOC, N) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N is N1-N2.
value(W1*W2, ASOC, N) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N is N1*N2.
value(W1/W2, ASOC, N) :-	%/
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N2 =\= 0,
    N is N1 div N2.
value(W1 mod W2, ASOC, N) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N2 =\= 0,
    N is N1 mod N2.

truth(W1 =:= W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 =:= N2.
truth(W1 =\= W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 =\= N2.
truth(W1 < W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 < N2.
truth(W1 > W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 > N2.
truth(W1 >= W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 >= N2.
truth(W1 =< W2, ASOC) :-
    value(W1, ASOC, N1),
    value(W2, ASOC, N2),
    N1 =< N2.
truth((W1, W2), ASSOC) :-
    truth(W1, ASSOC),
    truth(W2, ASSOC).
truth((W1; W2), ASSOC) :-
    (   
		truth(W1, ASSOC),
		!;
		truth(W2, ASSOC)
	).
	
%%%%%%%%%%%%%%%%%%%
% lab6, zadanie 1 %
%%%%%%%%%%%%%%%%%%%	
	
	
program([]) --> [].
program([INSTRUKCJA | PROGRAM]) --> 
	instrukcja(INSTRUKCJA), 
	['sep(;)'], 
	program(PROGRAM).

instrukcja(assign(ID, WYRAZENIE)) --> 
	identyfikator(ID), 
	['sep(:=)'], 
	wyrazenie(WYRAZENIE).
instrukcja(read(ID)) --> 
	['key(read)'], 
	identyfikator(ID).
instrukcja(write(WYRAZENIE)) --> 
	['key(write)'], 
	wyrazenie(WYRAZENIE).
instrukcja(if(WARUNEK, PROGRAM)) --> 
	['key(if)'], 
	warunek(WARUNEK), 
	['key(then)'], 
	program(PROGRAM), 
	['key(fi)'].
instrukcja(if(WARUNEK, PROGRAM1, PROGRAM2)) --> 
	['key(if)'], 
	warunek(WARUNEK), 
	['key(then)'], 
	program(PROGRAM1), 
	['key(else)'], 
	program(PROGRAM2),
	['key(fi)'].
instrukcja(while(WARUNEK, PROGRAM)) --> 
	['key(while)'], 
	warunek(WARUNEK), 
	['key(do)'], 
	program(PROGRAM), 
	['key(od)'].
				
wyrazenie(SKLADNIK + WYRAZENIE) --> 
	skladnik(SKLADNIK), 
	['sep(+)'], 
	wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK - WYRAZENIE) --> 
	skladnik(SKLADNIK), 
	['sep(-)'], 
	wyrazenie(WYRAZENIE).
wyrazenie(SKLADNIK) --> 
	skladnik(SKLADNIK).
				
czynnik(id(ID)) --> 
	identyfikator(ID).
czynnik(int(NUM)) --> 
	liczba_naturalna(NUM).
czynnik((WYRAZENIE)) --> 
	['sep(()'], 
	wyrazenie(WYRAZENIE), 
	['sep())'].

skladnik(SKLADNIK) --> 
	czynnik(SKLADNIK).
skladnik(CZYNNIK * SKLADNIK) --> 
	czynnik(CZYNNIK), 
	['sep(*)'], 
	skladnik(SKLADNIK).
skladnik(CZYNNIK / SKLADNIK) --> 
	czynnik(CZYNNIK), 
	['sep(/)'], 
	skladnik(SKLADNIK).
skladnik(CZYNNIK mod SKLADNIK) --> 
	czynnik(CZYNNIK), 
	['key(mod)'], 
	skladnik(SKLADNIK).
				
warunek(KONIUNKCJA ; WARUNEK) --> 
	koniunkcja(KONIUNKCJA), 
	['key(or)'], 
	warunek(WARUNEK).
warunek(KONIUNKCJA) --> 
	koniunkcja(KONIUNKCJA).
		
koniunkcja(PROSTY) --> 
	prosty(PROSTY).
koniunkcja(PROSTY , KONIUNKCJA) -->
	prosty(PROSTY), 
	['key(and)'], 
	koniunkcja(KONIUNKCJA).
				
prosty(WYRAZENIE1 =:= WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(=)'], 
	wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 =\= WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(/=)'], 
	wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 < WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(<)'], 
	wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 > WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(>)'], 
	wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 >= WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(>=)'], 
	wyrazenie(WYRAZENIE2).
prosty(WYRAZENIE1 =< WYRAZENIE2) --> 
	wyrazenie(WYRAZENIE1), 
	['sep(=<)'], 
	wyrazenie(WYRAZENIE2).
prosty((WARUNEK)) --> 
	['sep(()'], 
	warunek(WARUNEK), 
	['sep())'].


identyfikator(ID, [IdToken | Rest], Rest) :-
	atom_concat('id(', IdWithBracket, IdToken),
	atom_concat(ID, ')', IdWithBracket).
	
liczba_naturalna(NUM, [NumToken | Rest], Rest) :-
	atom_concat('int(', NumWithBracket, NumToken),
	atom_concat(AtomNum, ')', NumWithBracket),
	atom_number(AtomNum, NUM).
	
	
%%%%%%%%%%%%%%%%%%%
% lab5, zadanie 1 %
%%%%%%%%%%%%%%%%%%%

scanner(S, X) :-
	get_char(S, C),
	next_char(S, C, X),
	!.


space(' ').
space('\t').
space('\n').

key('read').
key('write').
key('if').
key('then').
key('else').
key('fi').
key('while').
key('do').
key('od').
key('and').
key('or').
key('mod').

sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

next_char(_, end_of_file, []) :-
	!.
next_char(S, C1, X) :-
	space(C1),
	!,
	get_char(S, C2),
	next_char(S, C2, X).
next_char(S, C1, [Token | T]) :-
	lower_case_letter(C1),
	read_key(S, C1, C2, '', H),
	!,
	key(H),
	atom_concat('key(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	next_char(S, C2, T).
next_char(S, C1, [Token | T]) :-
	int(C1),
	read_number(S, C1, C2, '', H),
	!,
	int(H),
	atom_concat('int(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	next_char(S, C2, T).
next_char(S, C1, [Token | T]) :-
	id(C1),
	read_id(S, C1, C2, '', H),
	!,
	id(H),
	atom_concat('id(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	next_char(S, C2, T).
next_char(S, C1, [Token | T]) :-
	sep_elem(C1),
	read_sep(S, C1, C2, '', H),
	!,
	sep(H),
	atom_concat('sep(', H, TokenPrefix),
	atom_concat(TokenPrefix, ')', Token),
	next_char(S, C2, T).
	
read_key(_, end_of_file, end_of_file, N, N) :-
	!.
read_key(_, C, C, N, N) :-
	\+ lower_case_letter(C),
	!.
read_key(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	read_key(S, C2, C3, N2, N).
	
read_number(_, end_of_file, end_of_file, N, N) :-
	!.
read_number(_, C, C, N, N) :-
	\+ int(C),
	!.
read_number(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	read_number(S, C2, C3, N2, N).
	
read_number(_, end_of_file, end_of_file, N, N) :-
	!.
read_number(_, C, C, N, N) :-
	\+ int(C),
	!.
read_number(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	read_number(S, C2, C3, N2, N).
	
read_id(_, end_of_file, end_of_file, N, N) :-
	!.
read_id(_, C, C, N, N) :-
	\+ id(C),
	!.
read_id(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	read_id(S, C2, C3, N2, N).
	
read_sep(_, end_of_file, end_of_file, N, N) :-
	!.
read_sep(_, C, C, N, N) :-
	\+ sep_elem(C),
	!.
read_sep(S, C1, C3, N1, N) :-
	atom_concat(N1, C1, N2),
	get_char(S, C2),
	read_sep(S, C2, C3, N2, N).


int('0') :-
	!.
int(C) :-
	atom_number(C, N),
	M is N - 1,
	atom_number(StringM, M),
	int(StringM).
	
id(Letter) :-
	string_length(Letter, 1),
	char_type(Letter, upper), !.
id(Id) :-
	get_string_code(1, Id, FirstCode),
	char_type(FirstCode, upper),
	atom_concat(FirstChar, Rest, Id),
	string_length(FirstChar, 1),
	id(Rest), !.
	

sep_elem(C) :-
	sep(C).
sep_elem(':').

lower_case_letter(Letter) :-
	string_length(Letter, 1),
	char_type(Letter, lower), !.	
	