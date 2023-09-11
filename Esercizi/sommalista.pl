:- lib(fd).


sommalista([A], A).
sommalista([H|T], S) :-
    S #= H + S1,
    sommalista(T, S1).


csp(L, S) :-
    L = [A, B, C],
    L :: 1..10,
    S :: 0..100,

    sommalista(L, S),

    labeling([A, B, C, S]).
