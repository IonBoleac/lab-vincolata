:- lib(fd).
:- lib(fd_global).

% ordina in ordine crescente gli elementi di una lista (cambia solo l'ordine, non la lista) dipende dal segno #< (crescente) o #> (decrescente)
ordina([]) :- !.
ordina([_]) :- !.
ordina([A, B|T]) :- ordina([B|T]), A #< B.

% sommalista(L, S) : S è la somma degli elementi della lista L
sommalista([A], A) :- !.
sommalista([H|T], S) :- sommalista(T, S1), S #= S1 + H.


% esponente(L, Lout) : Lout è la lista L elevata all'esponente 3
esponente([], []) :- !.
esponente([A|T], [B|Tout]) :- B #= A*A*A, esponente(T, Tout).


calc_fratello([], [], 0) :- !.
calc_fratello([A|Ta], [H|Th], Sum_max) :-
    calc_fratello(Ta, Th, Sum_max1),
    Sum_max #= Sum_max1 + H*A.


csp(L, L_pesi, Fratelli, Somma_pesi, Div, Sum_max, N) :-

    % creo le liste L, L_pesi e Fratelli di lunghezza N
    length(L, N),
    length(L_pesi, N),
    length(Fratelli, N),
    M #= N*N*N, % M è il massimo valore che può assumere un elemento della lista L_pesi

    % pongo i domini delle liste 
    L :: [1..N], L_pesi :: [1..M], Fratelli :: [0,1],

    % passo la lista L e ottengo la lista dei pesi -> L^3 di tutti gli elemnti della lista L
    esponente(L, L_pesi),

    % passo la lista dei pesi e ottengo la somma dei pesi
    sommalista(L_pesi, Somma_pesi),

    
    % impongo che il tesoro possa essere diviso in due parti uguale
    Div * 2 #= Somma_pesi,

    % passo la lista dei pesi e la lista dei fratelli, e ottengo la somma dei pesi dei fratelli... cioè nella lista fratelli si metterà 
    % in automatico 0 o 1 affinché la somma di uno dei due fratelli sia uguale a alla metà della somma dei pesi totali
    calc_fratello(L_pesi, Fratelli, Sum_max),
    Sum_max #= Div,

    % L deve essere una lista ordinata e senza ripetizioni
    ordina(L),
    fd_global:alldifferent(L),
    
    % labeling
    labeling(L),
    labeling(Fratelli).

/* % csp(L, L_pesi, Somma, Div, L1, L2, N) : L è la lista di partenza, L_pesi è la lista dei pesi, Somma è la somma dei pesi, Div è la divisione per 2 della somma dei pesi, 
L1 è la lista del primo fratello, L2 è la lista del secondo fratello, N è la lunghezza della lista di partenza */
% csp(8, L, L_pesi, M, Somma, Div, L1, L2).

csp1(L, L_pesi, Somma, Div, L1, L2, N) :-
    length(L, N),
    length(L_pesi, N),
    M #= N*N*N,
    L_pesi :: [1..M],
    L :: [1..N],
    L1 :: [1..M],
    L2 :: [1..M],


    esponente(L, L_pesi),
    sommalista(L_pesi, Somma),
    Div * 2 #= Somma,

    sommalista(L1, Sum1),
    sommalista(L2, Sum2),
    Sum1 #= Sum2,
    Sum1 #= Div,

    append(L1, L2, Ltot),

    fd_global:alldifferent(L),
    fd_global:alldifferent(Ltot),
    
    ordina(L),

    labeling(L),
    labeling(L1),
    labeling(L2).
    