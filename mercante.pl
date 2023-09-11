/*
Un commesso viaggiatore deve passare per un insieme di città e 
poi tornare alla città iniziale, percorrendo meno chilometri possibile.

Per ogni coppia di città collegate da una strada, è riportata la 
distanza in un insieme di fatti dista/3
*/

:-lib(fd).
:-lib(propia).
:-lib(listut).

ncitta(10).
dista(1, 2, 88).
dista(1, 3, 66).
dista(1, 4, 60).
dista(1, 5, 26).
dista(1, 6, 49).
dista(1, 7, 92).
dista(1, 8, 18).
dista(1, 9, 89).
dista(1, 10, 74).
dista(2, 1, 88).
dista(2, 3, 71).
dista(2, 4, 76).
dista(2, 5, 55).
dista(2, 6, 99).
dista(2, 7, 39).
dista(2, 8, 50).
dista(2, 9, 82).
dista(2, 10, 73).
dista(3, 1, 66).
dista(3, 2, 71).
dista(3, 4, 57).
dista(3, 5, 8).
dista(3, 6, 58).
dista(3, 7, 17).
dista(3, 8, 75).
dista(3, 9, 51).
dista(3, 10, 34).
dista(4, 1, 60).
dista(4, 2, 76).
dista(4, 3, 57).
dista(4, 5, 44).
dista(4, 6, 78).
dista(4, 7, 87).
dista(4, 8, 64).
dista(4, 9, 32).
dista(4, 10, 44).
dista(5, 1, 26).
dista(5, 2, 55).
dista(5, 3, 8).
dista(5, 4, 44).
dista(5, 6, 73).
dista(5, 7, 9).
dista(5, 8, 95).
dista(5, 9, 24).
dista(5, 10, 95).
dista(6, 1, 49).
dista(6, 2, 99).
dista(6, 3, 58).
dista(6, 4, 78).
dista(6, 5, 73).
dista(6, 7, 91).
dista(6, 8, 46).
dista(6, 9, 56).
dista(6, 10, 72).
dista(7, 1, 92).
dista(7, 2, 39).
dista(7, 3, 17).
dista(7, 4, 87).
dista(7, 5, 9).
dista(7, 6, 91).
dista(7, 8, 92).
dista(7, 9, 47).
dista(7, 10, 92).
dista(8, 1, 18).
dista(8, 2, 50).
dista(8, 3, 75).
dista(8, 4, 64).
dista(8, 5, 95).
dista(8, 6, 46).
dista(8, 7, 92).
dista(8, 9, 84).
dista(8, 10, 62).
dista(9, 1, 89).
dista(9, 2, 82).
dista(9, 3, 51).
dista(9, 4, 32).
dista(9, 5, 24).
dista(9, 6, 56).
dista(9, 7, 47).
dista(9, 8, 84).
dista(9, 10, 94).
dista(10, 1, 74).
dista(10, 2, 73).
dista(10, 3, 34).
dista(10, 4, 44).
dista(10, 5, 95).
dista(10, 6, 72).
dista(10, 7, 92).
dista(10, 8, 62).
dista(10, 9, 94).


% somma_lista(L, Sum) -> Sum è la somma della lista di interi L
somma_lista([], 0) :- !.
somma_lista([H|T], Sum) :-
    somma_lista(T, Sum1),
    Sum #= Sum1 + H.



csp(L, Sum) :-
    % L è la lista delle città visitate in ordine dal commesso viaggiatore
    ncitta(N),
    length(L, N),
    L :: [1..N],
    

    % vincoli
    alldifferent(L), % città differenti

    % vincolo sum
    nth1(1, L, P),
    csp_sum(L, P, Sum),


    % labeling
    min_max(labeling(L), Sum).
    % labeling(L).
   
csp_sum([U], Primo, Dist) :- 
    dista(U, Primo, Dist) infers ac.

csp_sum([A, B|T], Primo, Sum) :-
    dista(A, B, Dist) infers ac,
    Sum #= Dist1 + Dist,
    csp_sum([B|T], Primo, Dist1).

