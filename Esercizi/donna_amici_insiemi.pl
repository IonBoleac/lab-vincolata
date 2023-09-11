% Una donna vuole invitare N amici a cena.
% Per N(N-1)/6 giorni vuole organizzare delle 
% cene, ciascuna con esattamente 3 invitati in 
% modo tale che gli stessi 2 amici non si 
% trovino due (o più) volte a cena insieme
% In altre parole, in ciascuno dei giorni ci 
% devono essere 3 invitati e l'intersezione degli 
% invitati di due giorni diversi può essere al 
% massimo di 1 persona

:- lib(fd).
:- lib(fd_sets).

csp(L, N) :-
    NumGiorni * 6 #= N * (N - 1),

    intsets(L, NumGiorni, 1, N),
    set_cardinalita(L),
    
    alldifferent(L),

    % intersezione tra tutti gli insiemi 
    all_intersection_mia(L),

    label_sets(L).

intersezione_mia(_, []).
intersezione_mia(Set, [H|T]) :-
    fd_sets:intersection(Set, H, Int), #(Int, Card), fd:(Card :: 0..1),
    intersezione_mia(Set, T).

all_intersection_mia([]).
all_intersection_mia([H|T]) :-
    intersezione_mia(H, T),
    all_intersection_mia(T).


set_cardinalita([]).
set_cardinalita([H|T]) :-
    #(H, 3),
    set_cardinalita(T).

label_sets([]).
label_sets([H|T]):-
    insetdomain(H, _, _, _),
    label_sets(T).


% csp(L, 10).