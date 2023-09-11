:- lib(fd).


diag_diff([], []).
diag_diff([A, B|T]) :-
    C #\= R + 1 #/\ C #\= R - 1,
    diag_diff(Rs, Cs).



csp(C, Rout, R, N) :-
    N #>= 4,
    length(R, N),
    length(C, N),
    length(Rout, N),
    R :: 1..N,
    C :: 1..N,
    Rout :: 1..N,
    alldifferent(R),
    alldifferent(C),
    diag_diff(R),
    labeling(R),
    labeling(Rout),
    labeling(C).





stampa_out([]).
stampa_out([R|Rs]) :-
    write(R),
    write('\n'),
    stampa_out(Rs).

scacchiera([L], 1, Grandezza) :- 
    L = [A, 1],
    A :: [1..Grandezza],
    ! .
scacchiera([R|Rs], N, Grandezza) :-
    N1 #= N - 1,
    R = [A, N],
    A :: [1..Grandezza],
    scacchiera(Rs, N1, Grandezza).

csp1(N, Sc):-
    N #>= 4,
    scacchiera(Sc, N, N).

    /*flatten(Sc, ScFlat),

    alldifferent(ScFlat),

    labeling(ScFlat).*/

