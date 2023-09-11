:- lib(fd).
%:- lib(fd_global).
:- import alldifferent/1 from fd_global.

csp(A, B, PrezzoTOT) :-
    [A, B] :: 1..5,

    Prezzi = [10, 5, 6, 8, 11],

    element(A, Prezzi, PrezzoA),
    element(B, Prezzi, PrezzoB),

    PrezzoA + PrezzoB #= PrezzoTOT,
    PrezzoTOT #< 15,
    fd_global:alldifferent([A, B]),

    labeling([A, B]).