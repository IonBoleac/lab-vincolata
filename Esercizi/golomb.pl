:- lib(fd).
:- lib(fd_global).
:- lib(lists).


golomb(L, N, Lmax, FlattenDistance) :-
    length(L, N),
    L :: 0..Lmax,
    

    calc_dist(L, Ldistanze),
    flatten(Ldistanze, FlattenDistance),

    fd_global:alldifferent(L),
    fd_global:alldifferent(FlattenDistance),

    ordina_list(L),
    labeling(L).

ordina_list([_]).
ordina_list([A, B|T]) :-
    A #< B,
    ordina_list([B|T]).

calc_dist([_], []).
calc_dist([H|T], [H1|T1]) :-
    distanza(H, T, H1),
    calc_dist(T, T1).

distanza(_, [], []).
distanza(Valore, [H|T], [Distanza|T1]) :-
    Distanza #= H - Valore,
    Distanza #> 0, 
    distanza(Valore, T, T1).

% golomb(L,27, 553, Ldist).