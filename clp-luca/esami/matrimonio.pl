:- lib(fd).
:- lib(fd_sets).

:- [matrimonio_db].
csp(L,Costo) :-
    %input
    num_invitati(NI),
    num_tavoli(NT),
    capacita(Capacita), 

    %recupero tutti i conflitti come lista di coppie
    findall([A,B],conflitto(A,B),Lconflitti),
    findall([A,B],conosce(A,B),Lconosce),

    intsets(L,NT,1,NI),

    %numero di persone per tavolo
    imponi_cardinalita(L,Capacita),

    %le persone non possono ripetersi
    all_disjoint(L),

    %costo
    costo(Lconosce,L,Costo),

    %vincolo conflitti
    vincolo_conflitti(Lconflitti,L),

    NegCosto #= - Costo,
    minimize( labeling_insiemi(L), NegCosto).

imponi_cardinalita([],_).
imponi_cardinalita([H|T],Capacita) :- 
    #(H,Card), Card #=< Capacita, 
    imponi_cardinalita(T,Capacita).

labeling_insiemi([]).
labeling_insiemi([H|T]) :- insetdomain(H,_,_,_), labeling_insiemi(T). %al posto del labeling per insiemi

vincolo_conflitti([],_).
vincolo_conflitti([H|T], L) :- imponi_vincolo_conflitti(H,L), vincolo_conflitti(T,L).

imponi_vincolo_conflitti(_,[]).
imponi_vincolo_conflitti(Conflitto, [H|T]) :- fd_sets:intersection(Conflitto,H,Inter), #(Inter,Card), Card #=< 1,  imponi_vincolo_conflitti(Conflitto,T). 

costo([],_,0).
costo([H|T], L, Costo) :-  
    imponi_costo(H,L, Trovato), 
    costo(T,L, Trovato1), 
    Costo #= Trovato1 + Trovato .

imponi_costo(_,[],0).
imponi_costo(Conflitto, [H|T], TrovatoTot) :- 
    fd_sets:intersection(Conflitto,H,Inter), #(Inter,Card), Card #= 2 #<=> Trovato,  
    imponi_costo(Conflitto,T, Trovato1), 
    TrovatoTot #= Trovato1 + Trovato. 