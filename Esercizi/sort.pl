:- lib(fd).


ordina([]).
ordina([_]).
ordina([A, B|T]) :- ordina([B|T]), A #> B.


csp(L) :-
    length(L, 10),
    L :: 1..11,

    ordina(L),

    labeling(L).