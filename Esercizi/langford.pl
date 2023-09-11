:-lib(fd).
:-lib(fd_global).
:- lib(listut).

csp(L, N) :-
    Dim #= N*2,
    length(L, Dim),
    L :: 1..N,

    set_occurences(L, N),

    imposta_blocchi(L, L, 1),

    labeling(L).

imposta_blocchi([], _, _).
imposta_blocchi([H|T], L, Idx) :-
    PosAvanti #= Idx + H + 1,
    PosIndietro #= Idx - H - 1,
    nth1(PosAvanti, L, H) #\/ nth1(PosIndietro, L, H),
    Idx1 #= Idx + 1,
    imposta_blocchi(T, L, Idx1).



set_occurences(_, 0).
set_occurences(L, Num) :-
    fd_global:occurrences(Num, L, 2),
    set_occurences(L, Num1),
    Num1 #= Num - 1.

% csp(L, 4).