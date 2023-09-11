:- lib(fd).

ordina([]) :- !.
ordina([_]) :- !.
ordina([A, B|T]) :- ordina([B|T]), A #< B.


csp(L, M) :- 
    length(L, M),
    L :: [1..M],
    ordina(L),
    labeling(L).


