% Carico le librerie necessarie
:- lib(fd).
:- lib(fd_global).


sommalista([], 0) .
sommalista([H|T], S) :- 
    sommalista(T, S1), 
    S #= S1 + H.

clp([A, B, C, D, E], S) :- 
    % definisco le variabili
    A :: 0..100, 
    B :: 0..100,
    C :: 0..100,
    D :: 0..100,
    E :: 0..100,
    sommalista([A, B, C, D, E], S),
    labeling([A, B, C, D, E]).



