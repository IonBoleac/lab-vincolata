:- lib(fd).

csp(L, Tot) :-
    L = [T1, T2, T3, T4, T5, T6, T7, T8],
    L :: 0..10000,
    NumSoldatiPerTenda #= 9,

    sumList([T1, T2, T3], NumSoldatiPerTenda),
    sumList([T3, T4, T5], NumSoldatiPerTenda),
    sumList([T5, T6, T7], NumSoldatiPerTenda),
    sumList([T7, T8, T1], NumSoldatiPerTenda),
    sumList(L, Tot),

    labeling(L).

main(L, Tot) :-
    min_max(csp(L, Tot), Tot).

sumList([], 0).
sumList([H|T], Sum) :-
    Sum #= H + Sum1,
    sumList(T, Sum1).