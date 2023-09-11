:- lib(fd).
:- lib(fd_global_gac).


% calcola la distanza tra tutti gli elementi di una lista e le inserisce in un'altra lista tali distanze
distanze([A,B], [C]) :- C #= B-A, !.
distanze([A, B|T], [C|Td]) :- C #= B-A, distanze([B|T], Td).

% somma tutti gli elementi di una lista
sommalista([], 0) .
sommalista([H|T], S) :- 
    sommalista(T, S1), 
    S #= S1 + H.

csp(L, D, N) :-
    length(L, 10),
    length(D, 9),
    L :: [1..10000],
    D :: [1..10000],
    distanze(L, D),

    % sommalista(D, ),

    fd_global_gac:alldifferent(L),
    fd_global_gac:alldifferent(D),

    labeling(L).