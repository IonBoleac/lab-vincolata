:- lib(fd).
:- lib(fd_sets).

csp(N, L, Giorni) :-
    fd:(Giorni*6 #= N*(N-1)),
    fd_sets:(intsets(L, Giorni, 1, N)),

    % cardinalità di ogni insieme della lista L
    cardinalita(L),


% imponi i vincoli di intersezione
    imponi_intersezioni(L, L),
    % all_intersection(L, LInt),
    
    % labeling per gli insiemi
    all_insetdomain(L, _, _, _).

list_Int([]).
list_Int([Int|T]) :- 
    fd_sets:(#(Int, Card)),
    fd:(Card :: 0..1),
    list_Int(T).

% labeling per gli insiemi
all_insetdomain([], _, _, _).
all_insetdomain([H|T], _, _, _) :-
    fd_sets:(insetdomain(H, _, _, _)),
    all_insetdomain(T, _, _, _).


% imponi i vincoli di intersezione
imponi_intersezioni([], _).
imponi_intersezioni([A|T], [_|T1]) :-
    intersezione_singola(A, T1),
    imponi_intersezioni(T, T1).

intersezione_singola(_, []).
intersezione_singola(A, [B|T]) :-
    fd_sets:intersection(A, B, Int),
    fd_sets:(#(Int, Card)),
    fd:(Card :: 0..1),
    intersezione_singola(A, T).

% cardinalità di ogni insieme della lista L
cardinalita([A]) :- fd_sets:(#(A, 3)).
cardinalita([H|T]) :- 
    fd_sets:(#(H, 3)), 
    cardinalita(T).

% [cena_N_amici].