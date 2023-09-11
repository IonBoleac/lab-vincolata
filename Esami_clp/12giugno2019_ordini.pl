:- lib(fd).
:- lib(listut).
:- lib(fd_global).
:- lib(propia).
:- [production].



% lista L => indice corrisponde all'Id dell'ordine e il valore corrisponde a quando viene compiuto l'ordine in questione 


csp(L) :-
    endtime(EndTime),
    findall(ordine(ID, DeadLine), ordine(ID, DeadLine), Lordini),
    findall(precedenza(ID1,ID2), precedenza(ID1,ID2), Lprecedenze),

    length(Lordini, Dim),
    length(L, Dim),
    L :: 0..EndTime,
    fd_global:alldifferent(L),

    % imponi le precedenze
    imponiLePrecedenze(Lprecedenze, L),

    % calc guadagno
    calcolaGuadagno(Lordini, L, Guadagno),

    NegGuadagno #= -Guadagno,

    % massimizzo il guadagno 
    min_max(labeling(L), NegGuadagno).


imponiLePrecedenze([], _).
imponiLePrecedenze([precedenza(ID1, ID2)|Tordini], L) :-
    nth1(ID1, L, Val1), nth1(ID2, L, Val2),
    Val1 #< Val2,
    imponiLePrecedenze(Tordini, L).

calcolaGuadagno([], _, 0).
calcolaGuadagno([ordine(Id, DeadLine)|Tordini], L, Costo) :-
    nth1(Id, L, Valore),
    DeadLine #>= Valore #<=> B,
    Costo #= Costo1 + B,
    calcolaGuadagno(Tordini, L, Costo1).

