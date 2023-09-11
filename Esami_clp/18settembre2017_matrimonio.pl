:- lib(fd).
:- lib(fd_sets).
:- [matrimonio].

csp(S, NumConoscenze) :-
    num_tavoli(NumTavoli),
    num_invitati(NumInvitati),
    capacita(CapacitaTavolo),
    findall([A, B], conflitto(A, B), ListaConflitti),
    findall([A, B], conosce(A, B), ListaConosce),

    intsets(S, NumTavoli, 1, NumInvitati),
    all_disjoint(S),

    % imposta cardinalità
    impCard(S, CapacitaTavolo),

    % imposta il vincolo dei conflitti
    impConflitti(ListaConflitti, S),

    impConoscenze(ListaConosce, S, NumConoscenze),

    NegNumConoscenze #= -NumConoscenze,
    min_max(label_sets(S), NegNumConoscenze).



impConoscenze([], _, 0).
impConoscenze([H|T], S, Conoscenze) :-
    impConoscenza(H, S, Con),
    Conoscenze #= Con + Conoscenze1,
    impConoscenze(T, S, Conoscenze1).
impConoscenza(_, [], 0).
impConoscenza(H, [Ss|Ts], Costo) :-
    fd_sets:intersection(H, Ss, S), 
    #(S, Card), fd:(Card :: 0..2),
    Card #= 2 #<=> B,
    Costo #= Costo1 + B,
    impConoscenza(H, Ts, Costo1).

impConflitti([], _).
impConflitti([H|T], S) :-
    impConflitto(H, S),
    impConflitti(T, S).
impConflitto(_, []).
impConflitto(H, [Ss|Ts]) :-
    fd_sets:intersection(H, Ss, S),
    #(S, Card), fd:(Card :: 0..1),
    impConflitto(H, Ts).
    
impCard([], _).
impCard([Ss|Ts], Val) :-
    #(Ss, Card), fd:(Card :: 0..Val),
    impCard(Ts, Val).


label_sets([]).
label_sets([S|Ss]) :-
        insetdomain(S,_,_,_),
	label_sets(Ss).