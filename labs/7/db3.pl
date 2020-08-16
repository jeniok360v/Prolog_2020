filozofowie :-
    mutex_create(F0),
    mutex_create(F1),
    mutex_create(F2),
    mutex_create(F3),
    mutex_create(F4),    
	thread_create(filozof(0, F4, F1), _),
    thread_create(filozof(1, F0, F2), _),
    thread_create(filozof(2, F1, F3), _),
    thread_create(filozof(3, F2, F4), _),
    thread_create(filozof(4, F3, F0), _).

filozof(X, L, R) :-
    format('[~w] mysli~n', [X]),
    format('[~w] chce prawy widelec~n', [X]),
    mutex_lock(R),
    format('[~w] podniosl prawy widelec~n', [X]),
    format('[~w] chce lewy widelec~n', [X]),
    mutex_lock(L),
    format('[~w] podniosl lewy widelec~n', [X]),
    format('[~w] je~n', [X]),
    mutex_unlock(R),
    format('[~w] odlozyl prawy widelec~n', [X]),
    mutex_unlock(L),
    format('[~w] odlozyl lewy widelec~n', [X]),   
    filozof(X, L, R).