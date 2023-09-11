:- lib(fd).

% L is a list and N is the number of elements in L that are equal to I.
% set_number(L, Cont, N, I).
set_number([], 0, _, _) :- !.
set_number([N|T], Cont, N, I) :- Cont1 #= Cont - 1, set_number(T, Cont1, N, I), Cont #= I.




% esponente(L, E, Lout) : Lout è la lista L elevata all'esponente E
esponente([], _, []) :- !.
esponente([A|T], E, [B|Tout]) :- B #= A*A*A, esponente(T, E, Tout).