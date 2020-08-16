jednokrotnie(Elem, Lista) :-
	select(Elem, Lista, ListaWyjsc1),
	\+(select(Elem, ListaWyjsc1, ListaWyjsc2)).
	
dwukrotnie(Elem, Lista) :-
	select(Elem, Lista, ListaWyjsc1),
	select(Elem, ListaWyjsc1, ListaWyjsc2),
	\+(select(Elem, ListaWyjsc2, ListaWyjsc3)).