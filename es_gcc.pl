% gcc(++Bounds, +Vars)

% Carico le librerie necessarie
:- lib(fd).
:- lib(fd_global_gac).

risolvi(L):-
    M = 0,
    D = 1,
    N = 2,
    O = 3,
    B = 4,

    Peter :: [M,D],
    Paul :: [M,D],
    Bob :: [D,N],

    L = [Peter,Paul,Bob],

    gcc([
        gcc(1,2,M),
        gcc(1,2,D),
        gcc(1,1,N),
        gcc(0,2,B),
        gcc(0,2,O)
    ], L),

    labeling(L).