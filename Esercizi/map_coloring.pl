% esercizio Map Coloring

:-lib(fd).


member_mio(X, [X|_]).
member_mio(X, [_|T]) :- member_mio(X, T).

csp(L) :-
    L = [A1, B2, C3, D4, E5],
    L #:: [red, gree, blue, yellow],
    A1 #\= B2, A1 #\= C3, A1 #\= D4, A1 #\= E5,
    B2 #\= C3, B2 #\= D4, B2 #\= E5,
    C3 #\= D4, 
    D4 #\= E5,

    labeling(L).
