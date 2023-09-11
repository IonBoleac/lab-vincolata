:- lib(fd).
:- lib(fd_global_gac).

% golomb(L, N, M) :- L è la lista di numeri di golomb di lunghezza N, dove M è il valore massimo che deve assumere l'ultimo elemento della lista L
% le distanze dei valori di L devono essere tutti differenti

% somma tutti gli elementi di una lista
sommalista([], 0) .
sommalista([H|T], S) :- 
    sommalista(T, S1), 
    S #= S1 + H.

% ordina in ordine crescente gli elementi di una lista (cambia solo l'ordine, non la lista) dipende dal segno #< (crescente) o #> (decrescente)
ordina([]) :- !.
ordina([_]) :- !.
ordina([A, B|T]) :- ordina([B|T]), A #< B.



% calcola la distanza tra tutti gli elementi vicini di una lista
distanze([A,B], [C]) :- C #= B-A, C#>0, !.
distanze([A, B|T], [C|Td]) :- C #= B-A, C#>0, distanze([B|T], Td).




% golomb(L, N, M) :- L è la lista di numeri di golomb di lunghezza N, dove M è il valore massimo che deve assumere l'ultimo elemento della lista L
dist(_, [], []) :- !.
dist(E, [H|T], [O|To]) :-
    O #= H-E,
    O #> 0,
    dist(E, T, To).

% funzione di golomb che restituisce tutte le distanze tra due tacche
golomb([A], []) :-!.
golomb([A|T], [Ldist|Ldist1]) :-
    golomb(T, Ldist1),
    dist(A, T, Ldist).
    

% estrai l'ultimo elemento di una lista L
ultimo_elemento([H], H) :- !.
ultimo_elemento([H|T], E) :-
    ultimo_elemento(T,E).

% estrai il primo elemento di una lista
primo_elemento([Primo|_], Primo).


csp(L, N, M, Ldist1) :-
    
    length(L, N),
    L :: [0..M],
    ultimo_elemento(L, M),
    primo_elemento(L, 0),
    

    golomb(L, Ldist),
    flatten(Ldist, Ldist1),
    fd_global_gac:alldifferent(L),
    fd_global_gac:alldifferent(Ldist1),

    % ordina(L),
    % fd:element(1,L,0),
    % fd:element(N,L,M),
    labeling(L).
