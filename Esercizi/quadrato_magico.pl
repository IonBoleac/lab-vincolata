:- lib(fd).
:- lib(fd_global).
:- lib(matrix_util).

csp(N, Righe, Col):-

    matrix(N, N, Righe, Col),
    NMax #= N*N,
    Righe :: 1..NMax,
    Col :: 1..NMax,

    % impostare che la somma delle righe e delle colonne sia uguale ad un valore costante

    SommaRighe #= SommaColonne,

    % gestione righe
    gestione_righe(Righe, SommaRighe),

    gestione_colonne(Col, SommaColonne),

    flatten(Righe, FlattenRighe),
    flatten(Col, FlattenCol),

    fd_global:alldifferent(FlattenCol),
    fd_global:alldifferent(FlattenRighe),

    labeling(FlattenRighe),
    labeling(FlattenCol).

sommaLista([], 0).
sommaLista([H|T], Somma) :- 
    Somma #= H + Somma1,
    sommaLista(T, Somma1).

gestione_righe([], _).
gestione_righe([H|T], SommaRiga) :-
    sommaLista(H, SommaRiga),
    gestione_righe(T, SommaRiga).

gestione_colonne([], _).
gestione_colonne([H|T], SommaColonna) :- 
    sommaLista(H, SommaColonna),
    gestione_colonne(T, SommaColonna).
