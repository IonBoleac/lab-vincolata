:-lib(fd).
%:- lib(fd_global).

:-import alldifferent/1 from fd_global.

csp(L):-
    length(L, 10),
    L :: 1..10,

    alldifferent(L),

    labeling(L).