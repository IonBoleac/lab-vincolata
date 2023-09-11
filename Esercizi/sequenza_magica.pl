:-lib(fd).
:- lib(fd_global).
:- lib(listut).



csp(L, N) :-
    length(L, N),
    L :: 0..N,

    vincoloPosizioni(L, 0, L),

    labeling(L).

vincoloPosizioni([], _, _).
vincoloPosizioni([H|T], Idx, L) :-
    occurrences(Idx, L, H),
    Idx1 #= Idx + 1,
    vincoloPosizioni(T, Idx1, L).


% csp(L, 8).
