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